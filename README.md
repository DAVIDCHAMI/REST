# SVE Rediseño Empresas Servicios OSP Test BDD - Screen Play
 
## Contenido ##
 
- [Prerrequisitos](#prerrequisitos)
- [Documentacion](#documentacion)
- [Componentes](#componentes)
- [Configuracion](#configuracion)
- [Licencia](#licencia)
- [Changelog](#changelog)
 
## Prerrequisitos ##
 
- JDK 1.8
- Maven 3.2.0+
- GIT LFS
 
## Documentacion ##
 
Lorem ipsum dolor sit amet, condimentum praesent pellentesque sed nunc habitasse ultrices. Velit congue viverra, felis curabitur volutpat,
fermentum lacus lacus sit sed libero.
 
Ver <url Confluence>
 
## Componentes ##
 
Version estable en producción: 1.1.0
 
### Parent pom (Si aplica) ###
 
* Maven:
     
~~~
    <dependency>
        <groupId>com.todo1.psf</groupId>
        <artifactId>t1-psf-my-parent</artifactId>
        <packaging>pom</packaging>
    </dependency>
~~~
 
* Modulos incluidos:
 
~~~
    <modules>
        <module>t1-psf-mod-1</module>
        <module>t1-psf-mod-2</module>
    </modules>
~~~
 
### Modulo 1 ###
 
Descripcion modulo 1, Lorem ipsum dolor sit amet....
 
* Maven:
     
~~~
    <dependency>
        <groupId>com.todo1.psf</groupId>
        <artifactId>t1-psf-mod-1</artifactId>
        <packaging>jar</packaging>
    </dependency>
~~~
 
### Modulo 2 ###
 
Descripcion modulo 2, Lorem ipsum dolor sit amet....
 
* Maven:
     
~~~
    <dependency>
        <groupId>com.todo1.psf</groupId>
        <artifactId>t1-psf-mod-2</artifactId>
        <packaging>war</packaging>
    </dependency>
~~~
 
 
 
## Construccion ##
 
```
#!bash
mvn clean install
 
```
 
## Configuracion ##
 
* Dependencias: N/A
* Base de datos: Configurar JDBC .......
* GIT: (Esta seccion solo aplica para repos que usen Git LFS)
 
**IMPORTANTE**
 
Este repositorio requiere LFS.
 
Se debe usar un cliente que maneje LFS tal como [SourceTree](https://www.sourcetreeapp.com).
 
Para agregar archivos a LFS usar el comando:
 
    git lfs track "*.xyz"
 
Para configurar Jobs de Jenkins usando LFS se debe seguir las instrucciones indicadas [aqui­](https://todo1jira.atlassian.net/wiki/x/DWMaDg)
 
Para mas informacion ver: [https://www.atlassian.com/git/tutorials/git-lfs](https://www.atlassian.com/git/tutorials/git-lfs)
 
 
## Licencia ##
 
(C) TODO1 SERVICES, INC. ('TODO1') All rights reserved.
 
This work is protected by the United States of America copyright laws.
All information contained herein is and remains the property of TODO1 [and its suppliers, if any]. Dissemination of this information or
reproduction of this material is not permitted unless prior written consent is obtained from TODO1 SERVICES, INC.
 
## Changelog ##
 
| Version     | Cambio    |
| --------|---------|
| 1.0.0 | Migracion subversion   |
| 1.0.1 | Defectos   |
| 1.1.0 | Requerimientos X, Y y Z   |

