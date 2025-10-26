# infra-prova-pratica
Repositório com artefatos para a Atividade Avaliativa Prática 01 (Disciplina: Infraestrutura de TI).

Estrutura sugerida:
- api/: Flask app, Dockerfile
- k8s/: manifests Kubernetes (Deployment + Service)
- terraform/: scripts Terraform para criar bucket S3 e usuário IAM

Instruções rápidas (local):
1. Construir imagem Docker:
   cd api
   docker build -t infra-prova-api:latest .

2. Rodar local:
   docker run --rm -p 5000:5000 infra-prova-api:latest
   curl http://localhost:5000/
   curl -X POST http://localhost:5000/sum -H "Content-Type: application/json" -d '{"a":3,"b":4.5}'

3. Kubernetes (minikube):
   minikube start --driver=docker
   minikube image load infra-prova-api:latest
   kubectl apply -f k8s/deployment.yaml
   kubectl apply -f k8s/service.yaml
   minikube service infra-prova-api-svc --url

4. Terraform (AWS or LocalStack):
   cd terraform
   terraform init
   # Para AWS real (aws configure set ...), configure credenciais
   terraform apply -auto-approve
   terraform output

   # Para LocalStack, adapte provider com endpoints apontando para http://localhost:4566
