# Helm: The Definitive Guide from Beginner to Master by Lauro Fialho Müller

## Folder structure

- 05-creating-charts
  - nginx
  - backend-app: default chart run by `helm create backend-app`
  
## Summaries

- [Section 02 - 04. Helm Fundamentals](./summary-02-04-helm-fundamentals.md)
- [Section 05. Creating Charts](./summary-05-creating-charts.md)
- [Section 6: Go Template Deep-Dive](./summary-06-go-template.md)
- Section 7 -> Find `helm-lauro-config-store` project

<details open>
  <summary>Click to Contract/Expend</summary>

## Section 7: [Optional] Coding a Key-Value Store API

Git in this section is managed in `../helm-lauro-config-store`

### 56. Project setup

Create a new github repository, `helm-lauro-config-store`

```sh
# parent directory from this git root folder.
git clone git@github.com:pcsmomo/helm-lauro-config-store.git
cd helm-lauro-config-store
```

```sh
npm init -y
touch Dockerfile .dockerignore compose.yaml
mkdir src
npm i --save-exact \
  express@4.21.1 \
  sequelize@6.37.5 \
  pg@8.13.1 \
  pg-hstore@2.3.4 \
  body-parser@1.20.3 \
  cors@2.8.5

npm install --save-exact --save-dev nodemon@3.1.7
```

### 57. Express app setup

```sh
curl localhost:3000
Hello World
```

#### After setting up `Dockerfile` and `compose.yaml`

```sh
docker compose up --build --watch

# by using --watch, we cannot use -d (detached) option..
```

- `Develop Watch` is a newer feature specifically designed for development workflows
- It's more efficient for development as it only syncs files that have changed

</details>
