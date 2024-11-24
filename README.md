
# Back Calculadora - GitHub Actions

Este repositorio contiene el backend de una calculadora y las configuraciones necesarias para su despliegue utilizando **GitHub Actions** y **Docker**.

---

## Entorno Local en Windows (Bash)

### Crear y Activar el Entorno Virtual
1. Crear el entorno virtual:
   ```bash
   python -m venv .venv
   ```
2. Activar el entorno:
   ```bash
   source .venv/Scripts/activate
   ```

### Instalar Requerimientos
Ejecuta el siguiente comando para instalar las dependencias:
```bash
pip install -r requirements.txt
```

---

## Ejecutar la Aplicación

Para iniciar la aplicación, utiliza el siguiente comando:
```bash
fastapi dev main.py --port 8000
```

---

## Solución a Problemas de Importación

Si encuentras problemas para importar módulos, añade las siguientes líneas al inicio de los scripts afectados:
```python
import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
```

---

## Pruebas

### Ejecutar Tests
Desde la raíz del proyecto, ejecuta las pruebas utilizando:
```bash
pytest
```

### Requerimientos para la API
Asegúrate de que la librería `fastapi[standard]` está instalada para un entorno completo de FastAPI:
```bash
pip install fastapi[standard]
```

---

## Docker

### Crear una Imagen
Asegúrate de haber configurado correctamente el archivo `Dockerfile`. Luego, ejecuta:
```bash
docker build --no-cache -t back-calculadora-daw .
```

### Crear un Contenedor
Usa el nombre o hash de la imagen para crear un contenedor. Lista las imágenes disponibles con:
```bash
docker images
```

Luego, ejecuta:
```bash
docker run -d -p 8000:8000 back-calculadora-daw
```

---

## Configuración para GitHub Actions

Para obtener el código del repositorio, generar una imagen Docker y subirla a Docker Hub, se utilizan las siguientes acciones del Marketplace de GitHub:

1. [Checkout Action](https://github.com/marketplace/actions/checkout)  
   No requiere configuración adicional.

2. [Build and Push Docker Images](https://github.com/marketplace/actions/build-and-push-docker-images)  
   Necesita configuración de usuario y token.

---

### Configuración del Token de Docker Hub

#### 1. Crear Variables de Entorno en GitHub
1. Ve al repositorio y haz clic en **Settings**.
   ![imagen 01](assets/github_action_01.png)
2. En el menú lateral, selecciona **Security → Secrets and variables → Actions**.
   ![imagen 02](assets/github_action_02.png)
3. Añade las variables necesarias para autenticarte:
   - **DOCKERHUB_USERNAME**: Tu nombre de usuario en Docker Hub.
   - **DOCKERHUB_TOKEN**: Un token generado en Docker Hub.  
   ![imagen 03](assets/github_action_03.png)

#### 2. Obtener el Token de Docker Hub
1. Accede a tu perfil en Docker Hub y ve a **Account Settings → Security → Personal Access Tokens**.
2. Genera un nuevo token, cópialo y guárdalo como valor de la variable **DOCKERHUB_TOKEN** en GitHub.
   ![imagen 04](assets/github_action_04.png)  
   ![imagen 05](assets/github_action_05.png)  
   ![imagen 06](assets/github_action_06.png)

Con estas configuraciones, tu flujo de trabajo en GitHub Actions estará listo para construir y gestionar imágenes Docker automáticamente.

## Configuración para subir imágenes a GitHub Packages

### Documentación y Actions utilizados

1. [Action: Build and Push Docker Images](https://github.com/marketplace/actions/build-and-push-docker-images)
2. [Action: Docker Login to GitHub Container Registry](https://github.com/marketplace/actions/docker-login)
3. [Documentación sobre el Container Registry](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry#authenticarse-en-el-container-registry)
4. [Workflow de acceso al registro con tokens](https://docs.github.com/en/packages/managing-github-packages-using-github-actions-workflows/publishing-and-installing-a-package-with-github-actions#upgrading-a-workflow-that-accesses-a-registry-using-a-personal-access-token)

### Obtención del Token con permisos y creación de una variable secreta

1. Se necesita un token con los permisos necesarios para subir el package. Para obtenerlo:
   - Ve a tu perfil en **Settings** → **Developer settings** → **Personal access tokens** → **Tokens (classic)**.
2. Al crear el token, asegúrate de habilitar los permisos para **workflow** y **packages**.
3. Una vez generado el token:
   - Ve a tu repositorio.
   - Entra a la configuración de **Secrets and variables**.
   - Crea un nuevo secret donde almacenarás el token para su uso en el workflow.

### Vincular la imagen con el repositorio utilizando el Dockerfile

Añade la siguiente etiqueta en tu archivo `Dockerfile` para asociar la imagen con tu repositorio:

```docker
LABEL org.opencontainers.image.source https://github.com/<username>/<repository-name>
```

### Cambiar el package a público

Si el workflow ha subido correctamente la imagen, es posible que necesites hacer el package público. Para ello:

1. Ve a tu perfil en GitHub.
2. Dirígete a la sección de **Packages**.
3. Busca el nombre del package subido.
4. Cambia la configuración de **privado** a **público**.

### Notas adicionales

- Asegúrate de que tu workflow tiene configuradas las acciones necesarias para autenticarte y realizar el push al registro.
- Revisa los logs del workflow en caso de errores para identificar configuraciones faltantes.