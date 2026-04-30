Vedhan Sri Beauty Academy - DevOps Project
ఈ ప్రాజెక్ట్ ఒక Full-stack Microservices అప్లికేషన్‌ను (Java Spring Boot, Python, React) AWS EKS క్లస్టర్ మీద Docker, Terraform మరియు GitHub Actions ఉపయోగించి ఆటోమేటెడ్‌గా డెప్లాయ్ చేసే ప్రక్రియను వివరిస్తుంది.

1. Project Directory Structure
ప్రాజెక్ట్ యొక్క ముఖ్యమైన ఫైల్స్ మరియు ఫోల్డర్స్ అమరిక:

Plaintext
vedhanSri-app/
├── .github/workflows/       # GitHub Actions (Terraform & CI/CD)
├── academy-service/         # Java Spring Boot Service (Maven)
├── booking-service/         # Python Service (FastAPI/Flask)
├── catalog-service/         # Python Service
├── frontend/                # React.js Frontend
├── k8s/                     # Kubernetes Manifests
│   ├── base/                # Namespaces, Secrets (envsubst templates)
│   ├── academy/             # Academy Deployment & Service
│   ├── booking/             # Booking Deployment & Service
│   ├── catalog/             # Catalog Deployment & Service
│   ├── frontend/            # Frontend Deployment & Service
│   └── ingress/             # Ingress Rules (ALB Controller)
├── terraform/               # Infrastructure as Code (AWS EKS, RDS, VPC)
└── docker-compose.yml       # Local testing setup
2. Infrastructure (IaC)
Terraform ఉపయోగించి మనం AWSలో ఈ క్రింది రిసోర్సెస్‌ని బిల్డ్ చేశాం:

VPC (vpc.tf): Public మరియు Private Subnets తో కూడిన సురక్షితమైన నెట్‌వర్క్.

EKS (eks.tf): Managed Kubernetes Cluster (Version 1.30).

RDS (rds.tf): డేటా స్టోరేజ్ కోసం Database instance.

Ingress (helm.tf, iam_lb_controller.tf): ట్రాఫిక్ మేనేజ్మెంట్ కోసం AWS Load Balancer Controller.

Security (security_groups.tf): సర్వీసుల మధ్య కమ్యూనికేషన్ కోసం ఫైర్‌వాల్ రూల్స్.

3. CI/CD Pipeline Flow
మనం రెండు రకాల వర్క్‌ఫ్లోలను ఉపయోగిస్తున్నాం:

Step 1: Infra Creation (terraform.yml)
Manual Trigger: workflow_dispatch ద్వారా మాన్యువల్‌గా రన్ చేస్తాం.

Terraform Apply: AWSలో క్లస్టర్ మరియు డేటాబేస్ సిద్ధం చేస్తుంది.

Step 2: App Build & Deploy (main.yaml)
Build: Java (Maven) మరియు Python కోడ్‌ని కంపైల్ చేస్తుంది.

Dockerize: ఒక్కో సర్వీస్‌కి ఇమేజ్‌ని క్రియేట్ చేస్తుంది (Docker Hub: lingannaj).

Secret Injection: envsubst ఉపయోగించి GitHub Secrets (DB_USERNAME_BASE64, etc.) ని db-secrets.yaml లోకి ఇంజెక్ట్ చేస్తుంది.

Deploy: kubectl apply ద్వారా EKS క్లస్టర్‌లోకి సర్వీసులను పంపుతుంది.

4. Key Deployment Commands
మనం ప్రాజెక్ట్‌లో వాడే ముఖ్యమైన కమాండ్స్:

Terraform Initialize & Apply:

Bash
cd terraform
terraform init
terraform apply --auto-approve
EKS కనెక్టివిటీ:

Bash
aws eks update-kubeconfig --name vedhansri-eks-cluster --region us-east-1
Docker Build (Manual):

Bash
docker build -t lingannaj/academy-service:latest ./academy-service
Secrets Verification:

Bash
kubectl get secrets -n vedhan-sri
5. Traffic Routing (Ingress)
బయట నుండి వచ్చే ట్రాఫిక్ ఎలా రూట్ అవుతుందంటే:

Internet -> AWS Application Load Balancer (ALB)

ALB ఇన్కమింగ్ రిక్వెస్ట్‌ను ingress-rules.yaml లోని రూల్స్ ప్రకారం సంబంధిత సర్వీస్‌కి పంపుతుంది.

/ -> Frontend Service

/api/academy -> Academy Service

6. Troubleshooting Guide
ఏవైనా ఎర్రర్స్ వస్తే ఈ క్రింది వాటిని చెక్ చేయాలి:

Docker Build Failure: Dockerfile పేరు (Case sensitive) మరియు ఫోల్డర్ పాత్ (./academy-service) సరిగ్గా ఉన్నాయో లేదో చూడాలి.

EKS Connection: IAM Permissions మరియు aws eks update-kubeconfig రన్ అయ్యిందో లేదో చూడాలి.

Secret Injection: envsubst తర్వాత db-secrets-final.yaml లో Base64 వాల్యూస్ సరిగ్గా రీప్లేస్ అయ్యాయో లేదో చెక్ చేయాలి.

Pod Status: kubectl get pods -A ద్వారా ఏ పాడ్ ఫెయిల్ అవుతుందో చూడాలి.