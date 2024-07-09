Projeto DevOps: Implementação de Microsserviços com Kubernetes na AWS (EKS)
Visão Geral
Este projeto envolve o design e a implementação de uma aplicação baseada em microsserviços no Kubernetes (K8s) usando a AWS (EKS). O projeto demonstra vários aspectos de implantação, gerenciamento e monitoramento de microsserviços em um ambiente de nuvem.

Etapas do Projeto
1. Design de Microsserviços
Identificamos os componentes de nossa aplicação e os organizamos em microsserviços separados. A aplicação inclui:

Serviço de Catálogo Backend
Serviço de Imagens Backend
Serviço Frontend
Cada serviço tem sua própria imagem Docker e configuração de implantação no Kubernetes.

2. Implementação no Kubernetes (AWS EKS)
Utilizamos o AWS EKS para implantar nosso cluster Kubernetes. As etapas envolvidas foram:

Configuração do Cluster AWS EKS:

Criamos um cluster EKS usando Terraform.
Configuramos funções e políticas IAM para o cluster.
Provisionamos recursos necessários como VPC, sub-redes e grupos de segurança.
Implantação de Microsserviços:

Usamos charts do Helm para implantar cada microsserviço.
Configuramos serviços e implantações para cada microsserviço.
Usamos ConfigMaps e Secrets do Kubernetes para gerenciar variáveis de ambiente e dados sensíveis.
3. Escalabilidade e Tolerância a Falhas
Autoscaling Horizontal de Pods:
Configuramos Autoscalers Horizontais de Pods (HPA) para gerenciar o número de réplicas de pods com base no uso de CPU.
Cluster Autoscaler:
Habilitamos o Cluster Autoscaler para escalonamento dinâmico de nós de trabalho no cluster EKS.
4. Atualização e Monitoramento
Atualizações Rolling:

Configuramos atualizações rolling para implantações para garantir implantações sem tempo de inatividade.
Monitoramento:

Integrado com AWS CloudWatch para logs e monitoramento.
Tecnologias Utilizadas
AWS EKS: Serviço Kubernetes gerenciado para implantação e gerenciamento de clusters Kubernetes.
Terraform: Ferramenta de Infrastructure as Code (IaC) para provisionamento e gerenciamento de recursos AWS.
Helm: Gerenciador de pacotes Kubernetes para implantação de charts do Helm.
Docker: Plataforma de containerização para empacotamento de microsserviços.
Kubernetes: Plataforma de orquestração para gerenciamento de aplicações containerizadas.
AWS CloudWatch: Serviço de monitoramento e observabilidade para recursos e aplicações AWS.
Lições Aprendidas
Gerenciamento eficaz de recursos Kubernetes usando Helm e Terraform.
Configuração de autoscaling para lidar com cargas variáveis.
Implementação de monitoramento e logging para melhor observabilidade.
Gerenciamento de dados sensíveis usando Secrets do Kubernetes.
Como Executar
Pré-requisitos
Conta AWS
AWS CLI configurado
Kubectl instalado
Terraform instalado
Helm instalado
Passos
Clonar o repositório:

sh
Copiar código
git clone <repository-url>
cd <repository-directory>
Provisionar o Cluster AWS EKS usando Terraform:

sh
Copiar código
cd terraform
terraform init
terraform apply
Implantar Microsserviços usando Helm:

sh
Copiar código
helm install backend-catalog ./charts/backend-catalog
helm install backend-images ./charts/backend-images
helm install frontend ./charts/frontend
Configurar Ingress:

sh
Copiar código
helm install nginx-ingress ./charts/nginx-ingress
Acessar a Aplicação:

Use o IP externo do controlador de ingress para acessar a aplicação.
Limpeza
Para limpar os recursos, execute os seguintes comandos:

sh
Copiar código
# Desinstalar charts do Helm
helm uninstall backend-catalog
helm uninstall backend-images
helm uninstall frontend
helm uninstall nginx-ingress

# Destruir o cluster EKS usando Terraform
cd terraform
terraform destroy
Conclusão
Este projeto demonstra a implantação e o gerenciamento de uma aplicação baseada em microsserviços na AWS EKS usando Kubernetes. Cobre aspectos chave como escalabilidade, tolerância a falhas, monitoramento e atualizações, fornecendo uma estrutura robusta para gerenciar microsserviços em um ambiente de nuvem.
