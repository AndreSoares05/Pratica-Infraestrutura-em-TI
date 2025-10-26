# 🧾 Relatório de Entrega — Atividade Avaliativa Prática 01

**Aluno:** Marcos André dos Santos Soares
**Disciplina:** Infraestrutura de TI  
**Data:** 21/10/2025  

---

## 🎯 Objetivo

O objetivo desta atividade foi desenvolver uma infraestrutura completa de aplicação em nuvem, utilizando **Docker**, **Kubernetes** e **Terraform**, integrando conceitos de **Infraestrutura como Código (IaC)** e **containerização**.  

A aplicação proposta é uma **API Flask** simples, empacotada em um contêiner Docker, implantada em um cluster **Kubernetes** e com recursos de **armazenamento e controle de acesso provisionados via Terraform** (AWS ou LocalStack).

---

## ⚙️ Componentes Entregues

- ✅ **API Flask funcional** (`api/app.py`) com duas rotas:
  - `/` → retorna mensagem de status  
  - `/sum` → soma dois números enviados em JSON
- 🐳 **Dockerfile** para empacotamento da aplicação.  
- ☸️ **Manifests Kubernetes** (`deployment.yaml` e `service.yaml`) para orquestração.  
- 🌩️ **Scripts Terraform** (`main.tf`, `variables.tf`, `outputs.tf`) para criação de bucket S3 e usuário IAM.  
- 📘 **README.md** com instruções completas de execução.  
- 🧾 **Relatório técnico (este documento)** com descrição dos passos e evidências.  

---

## 🧩 Passo a Passo da Implementação

### 1️⃣ Construção da Imagem Docker

Foi acessada a pasta da aplicação e construída a imagem local:

```bash
cd api
docker build -t infra-prova-api:latest .
2️⃣ Teste Local da API com Docker
Após a build, a API foi executada em um contêiner local na porta 5000:

bash
Copiar código
docker run --rm -p 5000:5000 infra-prova-api:latest
Em outro terminal, foram realizados os testes de requisições:

bash
Copiar código
curl http://localhost:5000/
curl -X POST http://localhost:5000/sum -H "Content-Type: application/json" -d '{"a":3,"b":4.5}'
Saída esperada:

json
Copiar código
{"a":3,"b":4.5,"sum":7.5}
3️⃣ Implantação no Kubernetes (Minikube)
O cluster foi inicializado via Minikube:

bash
Copiar código
minikube start --driver=docker
minikube image load infra-prova-api:latest
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
Para expor o serviço e obter o endereço de acesso:

bash
Copiar código
minikube service infra-prova-api-svc --url
API acessível via navegador ou curl usando o endpoint informado.

4️⃣ Provisionamento de Recursos com Terraform
Na pasta terraform/, foi inicializado o ambiente e aplicado o plano:

🟢 Em ambiente AWS real:
bash
Copiar código
terraform init
terraform apply -auto-approve
terraform output
🔵 Em ambiente LocalStack (simulação local):
bash
Copiar código
localstack start
terraform init
terraform apply -auto-approve
terraform output
Exemplo de saída:

ini
Copiar código
bucket_name = "infra-prova-1a2b3c4d"
📸 Evidências
Etapa	Evidência	Resultado
Docker Build	docker build -t infra-prova-api:latest .	Concluído com sucesso
Docker Run	curl http://localhost:5000/	Retornou mensagem “API de teste - Infraestrutura”
Kubernetes Deploy	kubectl get pods	Pod em estado Running
Terraform Apply	terraform output	Bucket criado corretamente

💬 Observações Técnicas
O Dockerfile foi otimizado para imagens leves (python:3.11-slim).

O Kubernetes Deployment define apenas 1 réplica, ideal para testes locais.

O Service utiliza o tipo NodePort para facilitar acesso via minikube service.

O Terraform foi configurado com provider AWS compatível com execução real ou via LocalStack, permitindo testes sem custo.

✅ Checklist de Entrega
Item	Descrição	Status
🧠	API Flask funcional	✅
🐳	Dockerfile configurado	✅
☸️	Manifests Kubernetes	✅
🌩️	Scripts Terraform	✅
📘	README completo	✅
🧾	Relatório técnico	✅
🗜️	Pacote .zip pronto para GitHub	✅

🧭 Conclusão
Durante a realização desta atividade, foi possível compreender na prática os conceitos de virtualização de aplicações com Docker, orquestração de contêineres com Kubernetes e provisionamento automatizado de recursos via Terraform.

O projeto demonstra a integração entre as camadas de infraestrutura moderna — desde o desenvolvimento até o deploy automatizado — consolidando habilidades essenciais em DevOps e Cloud Computing.

🧑‍💻 Autor
Nome: Marcos André
Curso: Infraestrutura em Ti
Data de Entrega: 21/10/2025
--- FIM ---
