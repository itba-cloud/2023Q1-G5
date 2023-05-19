*README:*

*CLOUD-G5-TP3*


| Alumno  | Legajo | Participación |
| ------------- | ------------- | -------------|
| Francisco Goyanes  | 61486  | 33% |
| Gaspar Maschietto  | 61847  | 33% |
| Lucía Vineys  | 60232  | 33% |



1. *<span style="text-decoration:underline;">Módulos</span>*
* *_VPC _*: Creamos un módulo para la creación de la VPC. Dentro de este módulo creamos en el archivo main.tf, la VPC, dos sub redes públicas y dos subredes privadas. Una para cada AZ. Creamos solamente dos subredes privadas para las capas de aplicación ya que no vamos a “deployar” nada desde terraform en la capa de persistencia. (Las subredes públicas las deployamos para alocar los NAT gateways que no son parte de esta entrega). Las private subnets las creamos para la alocación del recurso de cómputo (Lambda). Dentro del mismo módulo, creamos el archivo internet.tf donde deployamos el Internet Gateway porque es un recurso que se asocia directamente con la VPC. 

* *Bucket*: Creamos un módulo específico para la capa de presentación de nuestro menú estático. En esta capa de presentación se encuentran los tres buckets (www, Main y Logs). Además de la creación de los tres buckets, para lo que es el main bucket creamos el recurso para implementar la configuración de versioning, y la configuración de la página con un index.html y un error.html. Por último creamos el recurso para toda la carga de objetos en el main bucket.

* *_ApiGateway _*: Dentro del módulo Api Gateway, creamos el archivo api gateway siendo este el archivo main del módulo. En este archivo creamos la función lambda,  el recurso api gateway, y el api gateway en Rest, para que pueda conectar a los usuarios con nuestra función Lambda. Finalmente, configuramos el api gateway con el recurso method, para habilitar la comunicación a través de entradas http y definir qué acción debe realizar el api gateway. Utilizamos el método _“Get”_ para que se solicite la lambda. También levantamos el recurso de integración, para integrar el api gateway con el método y la lambda. Además, creamos el recurso de lambda permission para darle acceso al api gateway a la lambda. Por último creamos el recurso api gateway deployment para administrar la implementación del api gateway rest. Además creamos el recurso stage para administrar la etapa en la que se encuentra la implementación.

2. *<span style="text-decoration:underline;">Lista de los seis componentes a evaluar : </span>*

    	

* VPC
* Subnet
* Internet Gateway
* S3
* Lambda 
* Api Gateway
3. *<span style="text-decoration:underline;">Descripción y referencia de funciones y meta-argumentos utilizados:</span>*

	<span style="text-decoration:underline;">Funciones:</span>



* *Cidrsubnet*: Utilizamos esta función para calcular automáticamente una dirección para diferentes subredes dado un prefijo de IP.
* *Format*: Usamos format _para guardar cada objeto que se quiera guardar en el main bucket en la carpeta _resources. El primer argumento es el path a la carpeta resources y el segundo es el nombre del archivo en sí.

    La función se utiliza dentro del módulo bucket, en el archivo s3.tf, en el recurso aws_s3_objetct.

* *Replace*: Para el atributo key _dentro del recurso _aws_s3_object usamos la función replace para que reemplace el valor “html/” por un valor vacío (“”) ya que no queremos que en el key _de los objetos que se ingresan al bucket aparezca _“html/”.
* *Try*: Usamos esta función dentro del recurso_ aws_s3_object_ para probar dados diferentes objetos, diferentes tipos de datos. Lo usamos con un mapa(any) en la variable de objetos en el atributo type.
* *Index*: Lo utilizamos para determinar qué elemento de la lista (count) debe leer en cada respectivo caso.
* *Map*: Lo utilizamos ya que al utilizar merge y nuestros datos son string, necesitamos convertirlos en map u object
* *Jsonencode*: codificamos el api gateway id, el method id y el integration id con la sintaxis de json para establecer el redeployment del api gateway rest api.
* *Sha1*: Dada la cadena de jsons de la cadena  api gateway id, el method id y el integration id, nos crea un hash que al haber un cambio en los ids mencionados anteriormente va a “triggerear” un redeployment del api gateway.

	<span style="text-decoration:underline;">Los Meta-argumentos utilizados fueron: </span>



* *Depends_on:* Usamos este metadato dentro del metadato lifecycle _dentro del recurso _deployment del api gateway para <span style="text-decoration:underline;">definir dependencias** **</span>del redeployment _ya que depende de los _ids _del api gateway,_ api gateway method _y _api gateway integration.
* *Count*: Usamos el meta argumento count en varias ocasiones. 

    Por ejemplo, en la definición de las subnets, creamos cada subnet (pública o privada) por cantidad de zonas. Para crear varias subnets sin usar código redundante (es decir, hacer un resource para cada subnet privada y cada subnet pública) pusimos el meta argumento count en la definición del recurso subnet, _para que “_deploye” la cantidad de subnets dependiendo de la cantidad de availability zones _que contó. En una misma definición del recurso _aws_subnet, crea dos subnets. Es por esto que definimos solamente dos veces el recurso aws_subnet, para levantar 2 _subnets _públicas y 2 _subnets _privadas.

* *_ Provider_*: Usamos este meta argumento para declarar que vamos a utilizar los servicios de AWS.
* *Lifecycle*: Hicimos un lifecycle _dentro del recurso _api gateway deployment _para que cuando haya modificación en los _ids que dispara el trigger del redeployment, se cree el nuevo deployment y luego se destruya el viejo.
* *For each*: Usamos este meta argumento para iterar en la creación de recursos y poder reusar gran parte de la configuración definida para cada uno.

    Lo usamos para que busque la cantidad y cargue los “objetos”, en nuestro caso los html de index y error, en el bucket de dominio de la capa de presentación. 

4. *<span style="text-decoration:underline;">Diagrama de Arquitectura , solo las piezas elegidas:</span>*

En el diagrama de arquitectura incluimos todos los elementos elegidos para la entrega, además del NAT Gateway. Lo pusimos en la arquitectura más allá que no sea parte de la entrega para que tenga sentido la creación de las sub redes públicas. 

<img src=”Arquitectura.JPG”>
