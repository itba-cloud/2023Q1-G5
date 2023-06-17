TP 3 Grupo 5

Readme

| **Alumno**        | **Legajo** |  **Participación** |
|-------------------|------------|--------------------|
| Francisco Goyanes | 61486      | 33%                |
| Gaspar Maschietto | 61847      | 33%                |
| Lucía Vineys      | 60232      | 33%                |



# **Módulos**

-   **VPC:** Creamos un módulo para la creación de la VPC.

    Dentro de este módulo creamos en el archivo main.tf, la VPC, dos sub redes públicas y dos subredes privadas. Una para cada AZ. Creamos solamente dos subredes privadas para las capas de aplicación. (Las subredes públicas las deployamos para alocar los NAT gateways que no son parte de esta entrega). Las private subnets las creamos para la alocación del recurso de cómputo (Lambda).

    Dentro del mismo módulo, creamos el archivo internet.tf donde deployamos el Internet Gateway porque es un recurso que se asocia directamente con la VPC.

-   **Bucket**: Creamos un módulo específico para la capa de presentación de nuestro menú estático. En esta capa de presentación se crean los tres buckets (www, Main y Logs).
-   **ApiGateway:** En este módulo, creamos el api gateway con sus respectivas funcionalidades y la función lambda.
-   **DynamoDB:** Deployamos una tabla de DynamoDB para almacenar las ventas.
-   **Cloudfront:** Deployamos Cloudfront para direccionar a los usuarios a la capa de presentación con poca latencia.
1.  **Lista de los seis componentes a evaluar :**
-   VPC
-   S3
-   Lambda
-   Api Gateway
-   DynamoDB
-   Cloudfront
1.  **Descripción y referencia de funciones y meta-argumentos utilizados:**

Funciones:

-   **Cidrsubnet**: Utilizamos esta función para calcular automáticamente una dirección para diferentes subredes dado un prefijo de IP.
-   **Format**: Usamos *format* para guardar cada objeto que se quiera guardar en el main bucket en la carpeta *resources*. El primer argumento es el path a la carpeta resources y el segundo es el nombre del archivo en sí.

    La función se utiliza dentro del módulo *bucket*, en el archivo *s3.tf*, en el recurso *aws_s3_objetct.*

-   **Replace**: Para el atributo *key* dentro del recurso *aws_s3_object* usamos la función *replace* para que reemplace el valor *“html/”* por un valor vacío (“”) ya que no queremos que en el *key* de los objetos que se ingresan al bucket aparezca *“html/”*.
-   **Try**: Usamos esta función dentro del recurso *aws_s3_object* para probar dados diferentes objetos, diferentes tipos de datos. Lo usamos con un *mapa(any)* en la variable de objetos en el atributo *type*.
-   **Index**: Lo utilizamos para determinar qué elemento de la lista (*count*) debe leer en cada respectivo caso.
-   **Map**: Lo utilizamos ya que al utilizar merge y nuestros datos son string, necesitamos convertirlos en *map* u *object*
-   **Jsonencode**: codificamos el api gateway id, el method id y el integration id con la sintaxis de json para establecer el redeployment del api gateway rest api.
-   **Sha1**: Dada la cadena de jsons de la cadena api gateway id, el method id y el integration id, nos crea un hash que al haber un cambio en los ids mencionados anteriormente va a “triggerear” un redeployment del api gateway.

Los Meta-argumentos utilizados fueron:

-   **Depends_on:** Usamos este metadato dentro del metadato *lifecycle* dentro del recurso *deployment* del *api gateway* para definir dependencias del *redeployment* ya que depende de los *ids* del *api gateway,* *api gateway method* y *api gateway integration.*
-   **Count**: Usamos el meta argumento count en varias ocasiones.

    Por ejemplo, en la definición de las subnets, creamos cada subnet (pública o privada) por cantidad de zonas. Para crear varias subnets sin usar código redundante (es decir, hacer un resource para cada subnet privada y cada subnet pública) pusimos el meta argumento count en la definición del recurso *subnet,* para que “*deploye*” la cantidad de *subnets* dependiendo de la cantidad de *availability zones* que contó. En una misma definición del recurso *aws_subnet*, crea dos subnets. Es por esto que definimos solamente dos veces el recurso *aws_subnet*, para levantar 2 *subnets* públicas y 2 *subnets* privadas.

-   **Provider**: Usamos este meta argumento para declarar que vamos a utilizar los servicios de AWS.
-   **Lifecycle**: Hicimos un *lifecycle* dentro del recurso *api gateway* *deployment* para que cuando haya modificación en los *ids* que dispara el trigger del *redeployment*, se cree el nuevo deployment y luego se destruya el viejo.
-   **For each**: Usamos este meta argumento para iterar en la creación de recursos y poder reusar gran parte de la configuración definida para cada uno.

    Lo usamos para que busque la cantidad y cargue los “objetos”, en nuestro caso los html de index y error, en el bucket de dominio de la capa de presentación.

1.  **Diagrama de Arquitectura , solo las piezas elegidas:**

<img src="https://github.com/gmaschiettoitba/2023Q1-G5/blob/main/Arquitectura.png">
