# back calculadora github actions

## windows (bash)
- crear environment
```  
python -m venv .venv
```
- activar el environment
```
source .venv/Scripts/activate
```
- instalar los requerimientos
```  
pip install -r requirements.txt
```
## Ejecutar aplicación

  ```
  fastapi dev main.py --port 8001
  ```


---

Cuando no encuentra los módulos, añadir las siguientes lineas para importar los múdlos.

```py
import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
```

Requirements:  
Para la api utilizar
```py
fastapi[standard]
```

Ejecutar tests desde la raíz del proyecto:
```py
pytest

