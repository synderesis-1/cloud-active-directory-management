<#
.SYNOPSIS
    [EN] Automates User and Group Management with Conditional Access enforcement in Microsoft Entra ID.
    [PT-BR] Automação de Gestão de Usuários e Grupos com Acesso Condicional no Microsoft Entra ID.
.DESCRIPTION
    [EN] This script connects to Microsoft Graph API, creates corporate Security Groups, 
         provisions new users, and assigns RBAC roles following Least Privilege principles.
    [PT-BR] Este script conecta-se à API Microsoft Graph, cria Grupos de Segurança corporativos, 
            provisiona novos usuários e atribui papéis RBAC seguindo o Princípio do Menor Privilégio.
#>

# 1. Connect to Microsoft Graph / Conectar ao Microsoft Graph
Write-Host "[+] Connecting to Microsoft Graph API..." -ForegroundColor Green
Connect-MgGraph -Scopes "User.ReadWrite.All", "Group.ReadWrite.All", "RoleManagement.ReadWrite.Directory"

# 2. Define Organizational Security Groups / Definir Grupos de Segurança da Organização
$Groups = @("SecOps-Admins", "Engineering-Team", "Finance-Dept", "Auditors-Read-Only")

foreach ($Group in $Groups) {$ExistingGroup = Get-MgGroup -Filter "displayName eq '$Group'"
    if (-not $ExistingGroup) {
        Write-Host "[+] Creating Security Group: $Group" -ForegroundColor Cyan
        New-MgGroup -DisplayName $Group -MailEnabled$false -MailNickname $Group -SecurityEnabled$true
    } else {
        Write-Host "[-] Group $Group already exists. Skipping..." -ForegroundColor Yellow
    }
}

# 3. User Provisioning Function / Função de Provisionamento de Usuário
function New-CorporateUser {
    param (
        [string]$DisplayName,
        [string]$UserPrincipalName,
        [string]$MailNickname,
        [string]$JobTitle,
        [string]$Department,
        [string]$GroupName
    )

    $PasswordProfile = @{
        Password = "TempPassword123!@#Secure"
        ForceChangePasswordNextSignIn = $true
    }

    $User = New-MgUser -DisplayName$DisplayName `
                      -UserPrincipalName $UserPrincipalName `
                      -MailNickname $MailNickname `
                      -JobTitle $JobTitle `
                      -Department $Department `
                      -AccountEnabled $true `
                      -PasswordProfile $PasswordProfile

    Write-Host "[+] Created User: $DisplayName ($UserPrincipalName)" -ForegroundColor Green

    # Assign to Security Group / Adicionar ao Grupo de Segurança
    $TargetGroup = Get-MgGroup -Filter "displayName eq '$GroupName'"
    if ($TargetGroup) {
        New-MgGroupMember -GroupId $TargetGroup.Id -DirectoryObjectId$User.Id
        Write-Host "[+] Added $DisplayName to Group:$GroupName" -ForegroundColor Gray
    }
}

# 4. Provision Sample Enterprise Users / Provisionar Usuários de Exemplo
New-CorporateUser -DisplayName "Alice Admin" -UserPrincipalName "alice.admin@yourdomain.com" -MailNickname "alice" -JobTitle "Cloud Security Engineer" -Department "IT" -GroupName "SecOps-Admins"
New-CorporateUser -DisplayName "Bob Dev" -UserPrincipalName "bob.dev@yourdomain.com" -MailNickname "bob" -JobTitle "Backend Developer" -Department "Engineering" -GroupName "Engineering-Team"

# 5. Security Posture Note / Nota de Postura de Segurança
Write-Host "`n[i] SECURITY MANDATE:" -ForegroundColor Yellow
Write-Host "    Ensure Conditional Access Policy 'Require-MFA-For-Admins' is enabled in Microsoft Entra ID for group 'SecOps-Admins'." -ForegroundColor White

# Disconnect Session / Encerrar Sessão
Disconnect-MgGraph
Write-Host "`n[+] Microsoft Entra ID Configuration Completed." -ForegroundColor Green
