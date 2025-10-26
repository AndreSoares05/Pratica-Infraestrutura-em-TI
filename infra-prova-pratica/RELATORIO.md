# Relatório de Entrega - Atividade Avaliativa Prática 01

**Aluno:** ______________________
**Disciplina:** Infraestrutura de TI
**Data:** 21/10/2025

## Objetivo
Este repositório contém os artefatos solicitados: API Flask, Dockerfile, manifests Kubernetes e scripts Terraform para provisionamento de recursos AWS (ou LocalStack).

## O que foi gerado
- API Flask funcional (app.py) com rota de soma e rota raiz.
- Dockerfile para construção da imagem.
- Manifests Kubernetes: deployment.yaml e service.yaml.
- Terraform: main.tf, variables.tf e outputs.tf para criar bucket S3 e usuário IAM com política restrita.
- README com instruções de execução.
- Este arquivo de relatório.

## Passo a passo usado (comandos)
1. **Construir imagem Docker**
   ```
   cd api
   docker build -t infra-prova-api:latest .
   ```

2. **Testar container local**
   ```
   docker run --rm -p 5000:5000 infra-prova-api:latest
   curl http://localhost:5000/
   curl -X POST http://localhost:5000/sum -H "Content-Type: application/json" -d '{"a":3,"b":4.5}'
   ```

3. **Carregar imagem no cluster local (minikube/kind)**
   - Minikube:
     ```
     minikube image load infra-prova-api:latest
     kubectl apply -f k8s/deployment.yaml
     kubectl apply -f k8s/service.yaml
     minikube service infra-prova-api-svc --url
     ```
   - Kind:
     ```
     kind load docker-image infra-prova-api:latest --name <cluster-name>
     kubectl apply -f k8s/deployment.yaml
     kubectl apply -f k8s/service.yaml
     kubectl port-forward deployment/infra-prova-api 5000:5000
     ```

4. **Terraform**
   - AWS real:
     ```
     cd terraform
     terraform init
     terraform apply -auto-approve
     terraform output
     ```
   - LocalStack (exemplo):
     ```
     # iniciar localstack
     localstack start
     # configurar provider para endpoint http://localhost:4566
     terraform init
     terraform apply -auto-approve
     ```

## Evidências e Observações
- **Observação importante:** neste pacote eu gerei todos os arquivos necessários e um relatório com os passos e comandos para execução. Eu **não** executei comandos que interajam com recursos externos (Docker daemon, Minikube, Kind, Terraform aplicando na AWS/LocalStack) a partir deste ambiente; portanto quaisquer outputs de comandos, IDs de recursos ou prints devem ser gerados ao executar os passos no seu ambiente local. Forneço abaixo exemplos de saída esperada para referência.

### Exemplo de saída esperada (exemplificativa)
- `curl http://localhost:5000/`:
  ```json
  {"message":"API de teste - Infraestrutura","status":"ok"}
  ```
- `curl -X POST http://localhost:5000/sum -H "Content-Type: application/json" -d '{"a":3,"b":4.5}'`:
  ```json
  {"a":3,"b":4.5,"sum":7.5}
  ```
- `terraform output` (exemplo):
  ```
  bucket_name = "infra-prova-1a2b3c4d"
  ```

## Checklist de entrega
- [x] Código da API (api/app.py)
- [x] Dockerfile (api/Dockerfile)
- [x] Manifests Kubernetes (k8s/)
- [x] Scripts Terraform (terraform/)
- [x] README e relatório
- [x] Arquivo .zip pronto para subir no GitHub

## Recomendações finais
1. Se for usar AWS, crie credenciais de prova (perfil AWS CLI) e execute `terraform apply` apenas quando entender os recursos que serão criados.
2. Se não tiver conta AWS, use LocalStack conforme o guia fornecido.
3. Tire prints dos outputs (docker build, kubectl get pods, terraform output) e inclua no repositório ou no envio da avaliação.

--- FIM ---
