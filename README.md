# SIGNALSCAN

![GitHub last commit](https://img.shields.io/github/last-commit/gvraul8/signalscan)
![GitHub top language](https://img.shields.io/github/languages/top/gvraul8/signalscan)

![image](https://github.com/gvraul8/signalscan/assets/72313586/1a8fbf72-d468-41c3-ad78-6f54ecb97315)


**PARA VER LA DOCUMENTACION COMPLETA, LEER [MEMORIA](https://github.com/gvraul8/signalscan/blob/master/GonzalezVelazquez_FernadezDelMoralGarciaConsuegra_memoria.pdf)** 



Aplicación móvil realizada con Flutter que se especializa en la identificación y análisis de señales de tráfico, brindando a los usuarios una herramienta eficaz para comprender y gestionar la información vial de manera práctica y sencilla.

## Herramientas utilizadas

- **WireframeSketcher**. Para el prototipado de bocetos
- **Flutter**. Framework de código abierto desarrollado por Google para crear aplicaciones móviles nativas. Usa como lenguaje de programación Dart.
- **APIs de datos**. Se han usado dos apis de datos:
  - **NewsAPI (https://newsapi.ai/api/v1/article/getArticles)**. Para obtener noticias relacionadas con el tráfico y la seguridad vial.
  - **Roboflow (https://detect.roboflow.com/)**. Mediante esta API permitimos escanear la señal deseada, y obtener toda la información de ella. Esta API está basada en un modelo de visión por computador que implica identificar y localizar la presencia de una serie de objetos específicos de una imagen, en este caso, señales de tráfico. Para ello, utiliza algoritmos y modelos de aprendizaje automático.
- **Postman**. Para realizar las pruebas de las APIs

## Organización del proyecto 
Se ha considerado que la estructuración del proyecto carpetas ayuda a mantener una separación clara y organizada de la lógica del software, lo que facilita el mantenimiento y la escalabilidad del proyecto en el futuro.
El proyecto se ha estructurado en cuatro carpetas principales: components, models, pages y services. Cada una de estas carpetas tiene una función específica en la organización del código y la lógica del software.

![image](https://github.com/gvraul8/signalscan/assets/72313586/13ad6622-a567-486e-9015-e44758761ec2)




## Resultado final 

- **Ventana de inicio**
  
![image](https://github.com/gvraul8/signalscan/assets/72313586/4d2ff4a4-b3f8-4cf1-b13a-4051d6c76631)

  *  Seleccionar imagen desde galeria o usar cámara
   
![image](https://github.com/gvraul8/signalscan/assets/72313586/2c0224ad-a815-4ba5-8064-4038fbfc978e) ![image](https://github.com/gvraul8/signalscan/assets/72313586/c52a235e-0ed2-41e0-a558-4d856d516784) ![image](https://github.com/gvraul8/signalscan/assets/72313586/928174c4-2db8-4456-8e4c-f673845d59e5)

  * Ver detalles

![image](https://github.com/gvraul8/signalscan/assets/72313586/042607ed-95be-4b2d-97ba-7c70662b89b3)

- **Ventana de noticas** 

![image](https://github.com/gvraul8/signalscan/assets/72313586/da39577d-4a27-4038-bd4f-6cd55e5d9317)![image](https://github.com/gvraul8/signalscan/assets/72313586/0f9cdafd-fa60-4c1e-a02a-63a774ee84c2)![image](https://github.com/gvraul8/signalscan/assets/72313586/c64eaa38-86f2-4ebb-a785-045a8d4947a9)![image](https://github.com/gvraul8/signalscan/assets/72313586/f7d73af5-9aae-4cff-b8d0-3d35d922a404)


- **Ventana de señales**

![image](https://github.com/gvraul8/signalscan/assets/72313586/73fe1382-f466-46b4-b9f3-6f41dc53b5af)![image](https://github.com/gvraul8/signalscan/assets/72313586/cc71eb7a-4ecb-40ee-a7a6-f9dadb353761)![image](https://github.com/gvraul8/signalscan/assets/72313586/599fd32f-6b56-4b80-8029-ba0406e2de67)







