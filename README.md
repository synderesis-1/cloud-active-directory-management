# Cloud-Based Active Directory Setup & User Management

![Microsoft Entra ID](https://img.shields.io/badge/Identity-Entra%20ID-blue)
![PowerShell](https://img.shields.io/badge/Automation-PowerShell-blue)
![Security Policy](https://img.shields.io/badge/Security-Zero%20Trust-green)

Automated provisioning script and security architecture blueprint for managing enterprise identities in Microsoft Entra ID (formerly Azure AD).

---

## English

### Project Overview
This project demonstrates identity governance and access management in a cloud-native environment. Using PowerShell and Microsoft Graph API, it automates user lifecycle management, group hierarchies, and role assignments while applying Zero Trust security controls.

### Key Features
- **Identity Lifecycle Automation:** Automated user creation with mandatory password resets on first login.
- **Group Architecture:** Security group categorization (`SecOps-Admins`, `Engineering-Team`, `Finance-Dept`).
- **Least Privilege Access:** Role-based access control (RBAC) definitions for administrative vs non-administrative personnel.
- **Security Enforcement:** Framework ready for Multi-Factor Authentication (MFA) and Conditional Access policies.

### Prerequisites & Dependencies
- Windows PowerShell 5.1 or PowerShell 7+
- Microsoft Graph PowerShell SDK (`Microsoft.Graph`)
- Global Administrator or Privileged Role Administrator permissions in Entra ID

### How to Run
```powershell
# Install required Microsoft Graph module
Install-Module Microsoft.Graph -Scope CurrentUser

# Execute execution script
.\deploy_entra_id.ps1
```
---

## Português - BR

### Visão Geral do Projeto
Este projeto demonstra a governança de identidades e a gestão de acessos em um ambiente nativo em nuvem. Utilizando PowerShell e a API Microsoft Graph, ele automatiza o ciclo de vida de usuários, hierarquias de grupos e atribuições de papéis aplicando controles de segurança Zero Trust.

### Principais Funcionalidades
- **Automação do Ciclo de Vida de Identidades:** Criação automatizada de usuários com redefinição obrigatória de senha no primeiro acesso.
- **Arquitetura de Grupos:** Categorização por grupos de segurança (`SecOps-Admins`, `Engineering-Team`, `Finance-Dept`).
- **Acesso de Menor Privilégio:** Definições de controle de acesso baseado em papéis (RBAC) para equipes administrativas e operacionais.
- **Enforcement de Segurança:** Estrutura pronta para políticas de Acesso Condicional e Autenticação Multi-Fator (MFA).

### Pré-requisitos
- Windows PowerShell 5.1 ou PowerShell 7+
- SDK do Microsoft Graph em PowerShell (`Microsoft.Graph`)
- Permissões de Global Administrator ou Privileged Role Administrator no Entra ID

### Como Executar
```PowerShell
# Instalar o módulo do Microsoft Graph
Install-Module Microsoft.Graph -Scope CurrentUser
```
# Executar o script de provisionamento
.\deploy_entra_id.ps1
