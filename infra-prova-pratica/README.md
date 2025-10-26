# 🧩 Infra-Prova-Pratica

Repositório com os artefatos da **Atividade Avaliativa Prática 01** da disciplina **Infraestrutura de TI**.

Este projeto demonstra o uso integrado de **Docker**, **Kubernetes** e **Terraform** para provisionar e executar uma aplicação simples baseada em **Flask (Python)** — simulando um ambiente moderno de desenvolvimento e deploy em nuvem.

---

## 🗂️ Estrutura do Projeto

infra-prova-pratica/
├── api/ # Aplicação Flask + Dockerfile
│ ├── app.py
│ ├── requirements.txt
│ └── Dockerfile
│
├── k8s/ # Manifests Kubernetes (Deployment + Service)
│ ├── deployment.yaml
│ └── service.yaml
│
├── terraform/ # Infraestrutura como código (Terraform)
│ ├── main.tf
│ ├── variables.tf
│ └── outputs.tf
│
├── RELATORIO.md # Relatório detalhado da execução
└── README.md # Este arquivo

yaml
Copiar código

---

## 🚀 Instruções de Execução (Ambiente Local)

### 🐍 1. API Flask (Local)

A aplicação é uma API simples com duas rotas:
- `GET /` → retorna uma mensagem de status  
- `POST /sum` → recebe dois números (`a`, `b`) e retorna a soma

#### ▶️ Executar localmente (Docker)

```bash
cd api
docker build -t infra-prova-api:latest .
docker run --rm -p 5000:5000 infra-prova-api:latest
🔍 Testar API
Em outro terminal:

bash
Copiar código
# Teste básico
curl http://localhost:5000/

# Teste da rota de soma
curl -X POST http://localhost:5000/sum \
     -H "Content-Type: application/json" \
     -d '{"a":3,"b":4.5}'
📦 Saída esperada:

json
Copiar código
{"a":3,"b":4.5,"sum":7.5}
☸️ 2. Kubernetes (Local com Minikube)
🔧 Inicializar o cluster
bash
Copiar código
minikube start --driver=docker
📤 Carregar a imagem local para o Minikube
bash
Copiar código
minikube image load infra-prova-api:latest
📜 Aplicar os manifests
bash
Copiar código
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
🌐 Obter o endpoint do serviço
bash
Copiar código
minikube service infra-prova-api-svc --url
Acesse a URL exibida e teste as rotas (/ e /sum).

☁️ 3. Terraform (AWS ou LocalStack)
Este módulo cria:

Um bucket S3

Um usuário IAM com permissões limitadas

Uma política vinculada ao usuário

🧭 Passos principais
bash
Copiar código
cd terraform
terraform init
👉 Executar no ambiente AWS real
Configure suas credenciais com o AWS CLI:

bash
Copiar código
aws configure
Depois:

bash
Copiar código
terraform apply -auto-approve
terraform output
🧱 Executar com LocalStack (sem usar AWS)
Adapte o provider no main.tf para:

h
Copiar código
provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  s3_use_path_style           = true
  endpoints {
    s3 = "http://localhost:4566"
    iam = "http://localhost:4566"
  }
}
E então:

bash
Copiar código
terraform init
terraform apply -auto-approve
terraform output
📄 Exemplo de saída esperada:

ini
Copiar código
bucket_name = "infra-prova-1a2b3c4d"
🧾 Relatório e Evidências
O arquivo RELATORIO.md contém:

Passo a passo completo

Prints e outputs esperados

Checklist de entrega

Observações sobre execução em ambientes locais (Docker, Minikube, Terraform)

✅ Checklist de Entrega
Item	Descrição	Status
🧠	API Flask funcional	✅
🐳	Dockerfile configurado	✅
☸️	Manifests Kubernetes (Deployment + Service)	✅
🌩️	Terraform para recursos AWS	✅
📘	README completo e didático	✅
🧾	Relatório detalhado (RELATORIO.md)	✅

💡 Dicas Finais
Se usar AWS, prefira criar credenciais temporárias para a avaliação.

Para testes locais, LocalStack é uma alternativa segura.

Execute docker system prune -f após testar para liberar espaço.

Para envio no GitHub: compacte o diretório infra-prova-pratica/ e publique.

👨‍💻 Autor: Marcos Andre dos Santos Soares
📚 Disciplina: Infraestrutura de TI
🏫 Data: Outubro / 2025
