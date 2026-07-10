# px4_ros2_docker

Workspace **multi-repo**: el repositorio raíz gestiona SOLO el entorno de
desarrollo (Docker, devcontainer, tmuxinator, scripts de arranque). Cada paquete
ROS 2 vive en su **propio repositorio git anidado e independiente**, con su
propio remoto e historia.

## ⚠️ Regla de oro sobre git

**Antes de hacer `git add` / `git commit`, ubicá EN QUÉ repositorio estás.**

- Si el archivo está en la raíz (`Docker/`, `tmuxinator/`, `.devcontainer/`,
  scripts `*.sh`, `README.md`) → pertenece al **repo raíz**.
- Si el archivo está dentro de un paquete ROS (ej. `MUAV_psdk_offboard/...`) →
  pertenece al **repo anidado de ESE paquete**. Hay que `cd` dentro del paquete
  y commitear ahí.

Para saber a qué repo pertenece un archivo:

```bash
git -C <ruta_del_paquete> rev-parse --show-toplevel
```

## Repo raíz — entorno de desarrollo

Remoto: `https://github.com/arpoma16/px4_ros2_docker.git`

Solo trackea infraestructura de desarrollo. El `.gitignore` usa estrategia
**whitelist**: ignora todo en la raíz (`/*`) y habilita explícitamente con `!`
lo que sí se trackea. Por eso los paquetes ROS aparecen como "ignorados" desde
la raíz — es intencional, cada uno se maneja en su propio repo.

Lo que trackea el repo raíz:

- `Docker/`, `.devcontainer/`, `.vscode/`, `tmuxinator/`
- Scripts de arranque de contenedor (`container_run*.sh`, `createContainer.sh`, …)
- `Dockerfile`, `compose.yaml`, `docker-compose-nv.yml`
- `README.md`, `LICENSE`, `.gitignore`

Para trackear un archivo o carpeta NUEVA en la raíz hay que agregar su regla
`!` correspondiente en `.gitignore`.

## Paquetes ROS — repos anidados independientes

Cada uno es un repo git aparte. NO son submódulos del repo raíz; el raíz los
ignora a propósito. Estado actual:

| Paquete                   | Remoto                                                    |
|---------------------------|-----------------------------------------------------------|
| `aerostack2/`             | github.com/aerostack2/aerostack2                          |
| `as2_web_gui/`            | github.com/aerostack2/as2_web_gui                         |
| `MUAV_GCS_gz/`            | github.com/arpoma16/MUAV_GCS_gz                           |
| `MUAV_GCS_interfaces/`    | github.com/arpoma16/MUAV_GCS_interfaces                   |
| `MUAV_GCS_offboard/`      | github.com/arpoma16/MUAV_GCS_offboard                     |
| `MUAV_psdk_offboard/`     | **sin remoto configurado** (solo local, branch `master`) |
| `psdk_ros2/`              | github.com/arpoma16/psdk_ros2                             |
| `PX4-manu/`               | github.com/Manuhdezr/PX4-Autopilot                        |
| `px4_msgs/`               | github.com/PX4/px4_msgs                                   |
| `px4-ros2-interface-lib/` | github.com/Auterion/px4-ros2-interface-lib               |
| `uav_swarm_mission_arch/` | github.com/migueltg20/uav_swarm_mission_arch             |

Directorios en disco que **no** son repos git (código externo sin versionar
aquí): `Payload-SDK/`, `psdk_doc/`, `uav_media/`.

### Cómo commitear en un paquete ROS

```bash
cd MUAV_psdk_offboard         # entrar al repo del paquete
git status                    # confirmar que estás en el repo correcto
git add <archivo>             # staging selectivo
git commit -m "tipo(scope): ..."
```

## Convenciones de commits

- Formato **conventional commits** (`feat`, `fix`, `refactor`, `docs`, …).
- Un commit = un cambio atómico. No mezclar cambios no relacionados
  (ej. no meter un refactor de namespace junto con un fix de ffmpeg).
- Nunca agregar atribución de IA / `Co-Authored-By`.
