# Balanceador de Carga con Apache `mod_proxy_balancer` + Pruebas de Carga con Artillery

Proyecto final - Servicios Telemáticos 2025  
Implementación de un clúster de servidores web con balanceo de carga HTTP, configurado mediante el módulo `mod_proxy_balancer` de Apache. Se incluyen pruebas de carga automatizadas con Artillery sobre un entorno reproducible en **Vagrant + Ubuntu 22.04**.

---

## Requisitos

- [Vagrant](https://www.vagrantup.com/) >= 2.3.x  
- [VirtualBox](https://www.virtualbox.org/) >= 6.1.x  
- [Node.js](https://nodejs.org/) >= 18.x (para pruebas Artillery)  
- (Opcional) Artillery instalado globalmente:

```bash
npm install -g artillery
```

---

## Cómo levantar el entorno

Clona este repositorio y ejecuta:

```bash
git clone https://github.com/tu-usuario/balanceador-apache-artillery.git
cd balanceador-apache-artillery
vagrant up
```

Esto creará 3 máquinas virtuales:

| VM   | Rol              | IP              |
|------|------------------|-----------------|
| vm1  | Web Backend 1    | 192.168.50.10   |
| vm2  | Web Backend 2    | 192.168.50.20   |
| vm3  | Apache Balancer  | 192.168.50.30   |

---

## Verificar funcionamiento

Una vez levantadas las VMs:

```bash
curl http://192.168.50.30/
```

Verás cómo las respuestas se alternan entre VM1 y VM2 (balanceo activo).

También puedes ingresar a cada máquina:

```bash
vagrant ssh vm1
vagrant ssh vm2
vagrant ssh vm3
```

---

## Pruebas de Carga (Artillery)

Dentro de la carpeta `tests/` encontrarás escenarios de carga como `load_test.yml`.

### Ejecutar desde el host:

```bash
artillery run tests/load_test.yml -o tests/result.json
artillery report tests/result.json
```

### Alternativamente, ejecutar dentro de `vm3`:

```bash
vagrant ssh vm3
npm install -g artillery
artillery run /vagrant/tests/load_test.yml -o /vagrant/tests/result.json
```

---

## Estructura del repositorio

```bash
.
├── Vagrantfile                  # Define 3 VMs: vm1, vm2, vm3
├── provision/
│   ├── backend.sh               # Instala Apache y contenido web en VM1 y VM2
│   └── balancer.sh              # Configura Apache como balanceador en VM3
├── tests/
│   └── load_test.yml            # Escenario de prueba con Artillery
├── docs/
│   └── informe_ieee.docx          # Documento IEEE (en construcción)
└── README.md                    # Este archivo
```

---

## Roles asignados

| Integrante | Rol                           |
|------------|--------------------------------|
| Persona 1  | Infraestructura (Vagrant)      |
| Persona 2  | Backends Apache                |
| Persona 3  | Configuración del Balanceador  |
| Persona 4  | Pruebas de Carga (Artillery)   |
| Persona 5  | Documentación & Presentación   |

---

## Pendientes y mejoras sugeridas

- [ ] Agregar `Makefile` con comandos abreviados (`make up`, `make test`, etc.).
- [ ] Agregar CI con GitHub Actions para validar el `Vagrantfile` y YAML.
- [ ] Incluir una interfaz web simple en los backends (HTML o Node.js).
- [ ] Documentar más escenarios de carga y fallas.

---

## Licencia

MIT License — libre uso para fines educativos.

---

## Referencias útiles

- [Apache mod_proxy_balancer](https://httpd.apache.org/docs/2.4/mod/mod_proxy_balancer.html)
- [Guía de Vagrant](https://developer.hashicorp.com/vagrant/docs)
- [Documentación de Artillery](https://artillery.io/docs/)

