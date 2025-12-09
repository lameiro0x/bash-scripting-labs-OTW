# Indice

- [[#"Hacking"|"Hacking"]]
	- [[#"Hacking"#cat|cat]]
	- [[#"Hacking"#file|file]]
	- [[#"Hacking"#find|find]]
	- [[#"Hacking"#sed|sed]]
- [[#grep y awk|grep y awk]]
	- [[#grep y awk#cut|cut]]
	- [[#grep y awk#strings|strings]]
	- [[#grep y awk#base64|base64]]
	- [[#grep y awk#tr|tr]]
	- [[#grep y awk#xxd|xxd]]
	- [[#grep y awk#7z|7z]]
	- [[#grep y awk#Salida|Salida]]
	- [[#grep y awk#Procesos y puerto|Procesos y puerto]]
	- [[#grep y awk#diff|diff]]
	- [[#grep y awk#cron|cron]]
	- [[#grep y awk#git|git]]
	- [[#grep y awk#SSH|SSH]]

---
# "Hacking"

**Sacado de los ejercicios de OverTheWire**

## cat 

Para leer un archivo que es un guion ponerlo con la ruta detras, si estoy en ese wiswo directorio:

```bash
cat ./nombreArchivo     
```

Para leer archivo con espacios se puede autocompletar o poner asi:

```bash
cat ./palabra1\ palabra2\ palabraFinal      o       cat "nombreArchivoEntero"       o cat principio*     
```

Para buscar una linea unica en un archivo: (sort le facilita ala operacion uniq)

```bash
cat archivo | sort | uniq -u
```

Para saber la shell de alguien o un usuario:

```bash
cat /etc/passwd | grep "nombreUsuario"
```

---

## file

Para ver que tipo de archivo es, detalles y propiedades:

```bash
file "nombreArchivo"
```

## find

Puedo buscar archivos ocultos en todos los directorios desde mi ruta con:

```bash
find .
```

Para encontrar solo archivos:

```bash
find . -type f
```

Para buscar un archivo en concreto:

```bash
find . -type f -name "nombreArchivo"
```


Si quiero aplicarle un comando a todo output de un comando cobmn pipes uso xargs:

```bash
find . -type f -name "nombreArchivo" | xargs file
```

Esto me aplica file a todos los archivo que encuentre, se puede usar con rm, mkdir, ... todos los comandos

Para buscar un archivo que sea leible, no tenga permiso de escritura y tenga un tamano en concreto:

```bash
find . -type f -name "nombreArchivo" -readable ! -writable -size 1033c  # El menos c es para indicar que son bytes, si se quita son bits
```

Para con find buscar por un propietario, grupo y desde que punto hacer:

```bash
find RutaDesdeLaQueBusca -user "nombrePropietario" -group "nombreGrupo"  # Para la raiz solo seria un /
```

Si me dan muchos errores como "Permission denied" y solo quiero ver lo bueno: (el dev/null es como una papelera donde llevar lo que no queremos, se hace en otros comandos tambien, usarlo con cuidado, 2 marca para que lo que se lleve sea sterr)

```bash
find RutaDesdeLaQueBusca -user "nombrePropietario" -group "nombreGrupo" 2>/dev/null
```

Tambien en vez de llevarlo a /dev/null el stderr, lo pasa a stdin entonces ya no se ve, y el resto del output lo pasa a /dev/null y asi no se ve nada:

```bash
find RutaDesdeLaQueBusca -user "nombrePropietario" -group "nombreGrupo" >/dev/null 2>&1
```

## sed

Para sustituir valores en el output de un comando:

```bash
sed 's/argumentoAcambiar/LoQueSeQeuierePoner/'        # Para que se aplique a toda la linea y no solo a primer match poner al final una g minuscula
```

Tambien se puede usar ^ que sirve para que cualquier cosa que siga al siguiente texto lo ponga:

```bash
sed 's/^argumentoAcambiarYLoQueLeSigue/LoQueSeQeuierePoner/'       
```

Parecido a sed esta tr: (se aplica a todas las coincidencias, pero va caracter por caracter, mejor para caracteres) 

```bash
tr 'argumentoAcambiar' 'LoQueSeQeuierePoner'
```

Tambien se aplica a grep:

```bash
grep "^textoABuscar" 
```

# grep y awk

Tambien se puede designar en lo que queremos que termine y con -n nos dice que en linea estaba: (En este caso r)

```bash
grep "textoABuscar$" -n
```

Para quitar una linea que tiene una coincidencia con nuestro grep:

```bash
grep -v "textoABuscar"
```

Para hacer un grep que busque por dos parametros:

```bash
grep -E "textoABuscar1|textoABuscar2"
```

Si queremos saber que ponia en una linea en especifico con awk:

```bash
awk 'NR==numeroLinea' nombreArchivo
```

Para hacer un grep a un archivo en concreto:

```bash
grep "textoABuscar" nombreArchivo
```

awk tambien se puede comportar como grep: (aunque grep es mas rapido)

```bash
awk '/textoABuscar/' nombreArchivo
```

Aunque con awk puedo filtrar por argumentos:

```bash
awk '/textoABuscar/' nombreArchivo | awk '{print $nArgumento}'
```

Para quedarnos con el ultimo argumento:

```bash
awk '/textoABuscar/' nombreArchivo | awk 'NF{print $NF}'
```

---

## cut

Tambien puedo usar cut con el resto de comandos, que filtra a izquierda o derecha a partir de un caracter buscado: (util para separar por espacios)

```bash
cut -d "caracterABuscar" -f numeroOcurrencia
```

---

## strings

Para poder ver todas cadenas de caracter imprimible:

```bash
strings archivo
```

Para hacer un "while liner" que cuente lineas que tengan 3 simbolos de igual, apliacdo al caso anterior por ejemplo:

```bash
contador=1: strings data.txt | grep "===" | while read line: do echo "Linea $contador: $line"; let contador+=1; done
```

## base64

Puedo encriptar algo en base 64 con:

```bash
echo "textoAEncriptar" | base64
```

Y desencriptar:

```bash
echo "textoADesencriptar" | base64 -d
```

## tr

Si me dicen las letras estan rotadas un numero determinado de posiciones puedo arregralo; ej con 13 rotaciones:

Gur cnffjbeq vf WIAOOSFzMjXXBC0KoSKBbJ8puQm5lIEi

Cojo la primera y abarco todo el abecederio despues y antes de ella, incluyendo minusculas.

Y su sustitucion sera poner en el siguiente argumento trece posiciones mas adelante de la g en el abecedario, la t, y como hicimos con la g cubrir todo el abecedario incluyendo minusculas

```bash
echo "Gur cnffjbeq vf WIAOOSFzMjXXBC0KoSKBbJ8puQm5lIEi" | tr '[G-ZA-Fg-za-f]' '[T-ZA-St-za-s]'
```

---

## xxd

Para pasar algo a hexadecimal:

```bash
echo "textoAEncriptar" | xxd        # -ps para ver solo lo hexadecimal
```

Para pasar de hexadecimal a normal:

```bash
echo "textoAEncriptar" | xxd -r
```

---

## 7z

Para descomprimir lo mejor es 7z ya que es universal para todos los tipos de comprimidos y aparte permite listar lo el contenido de lo descomprimido: (ESTO NO LO DESCOMPRIME NI EXTRAE)

```bash
7z l nombreArchivo      # l es lo que hace que se muestre
```

Cuando lista, para fijarme solo en los nombres puedo hacor que con grep me muestre las filas que estan justo debajo:

```bash
7z l nombreArchivo | grep -A nLineas "Name"       # -A es para abajo, -B Para arriba y -C para arriba y abajo, y si quiero ver el ultimo le anado | tail -n 1 y si quiero solo ver el nombre le anado a todo esto | awk 'NF{print $NF}'
```

Para ver lo ultimo de cualquier listado es muy util:

```bash
comandoQueLista | tail -n 1
```

Y despues se extrae o descomprime con:

```bash
7z x nombreArchivo
```

---

## Salida

Para saber si el anterior comando ha saildo bien:

```bash
echo $?     # 0 es que ha salido bien, 1 que mal
```

Para simular un tipo de salida:

```bash
exit 0/1
```

---

## Procesos y puerto

Para ver lo que procesos hay puerto de mi equipo:

```bash
lsof -i:puerto
```

Tambien puedo ver la ruta desde la cual se ejecuta un proceso cualquiera de m ordenador con:

```bash
pwdx PID (id de proceso)
```

Para saber si tengo un puerto abierto: (conmprobar si fue exitoso con echo $?) (util cuando estoy conectado por ssh o lo que sea a otra maquina)

```bash
echo '' > /dev/tcp/mi_ip_privada/local(creo)/puerto
```

Me puedo comunicar con los puertos pasandoles contrasenas o cosas y a veces devuelven algo: (util cuando estoy conectado por ssh o lo que sea a otra maquina)

```bash
echo "LoQueQuieroPasar" | nc localhost puerto
```

Tambies se puede cotectar por telnet y uta vez conectado poner lo que sea y darle a enter y se envia:

```bash
telnet localhost puerto
```

A veces los puertos esatn encriptados por SSL ya sea en servidores o en el localhost, para poder hacer lo anterior y comunicarnos con ellos a pesar del SSL: (y despues le paso la info como con telnet)

```bash 
openssl s_client -connect ip_localhost_o_ipPublicaServidor:puerto
```

Para buscar puertos abiertos podemos hacernos un nmap a nosotros mismo o al servidor: (Si quiero que puerto va por SSL tengo que probar 1 por 1 el anterior comando)

```bash
nmap --open -T5 -v -n -puertoInical-puertoFinal ip
```

Si quiero ver todos los procesos que se esatn ejecutando a nivel de sistema en mi equipo:

```bash
ps -eo command
```

Con:

```bash
nc -nlvp puerto
```

No solo se pone una escucha sino que si escribimos debajo tambien manda esa informacion por ese puerto.

Si nos piden una contrasena de un pin a traves de un puerto podemos hacerle un ataque de fuerza bruta asi con un comando de terminal asi: (a parte del pin me pedia ponerle un texto que ya se conocia antes):

```bash
for i in {0000..9999};do echo "$i"; echo "VTextoConocido $i" | nc -w 1 localhost puerto | grep -v -E "Wrong|secret"; done 
```

Pero es muy lento, lo mejor es hacerlo a traves de un script en una carpeta temporal en caso de estar en un ssh ajeno, el script seria: (y se ejecuta y ya)

```bash
#!/bin/bash

for i in {0000..9999}; do
        echo "VAfGXJ1PBSsPSnvsjI8p759leLZ9GGar $i"
done | nc localhost 30002 | grep -v Wrong | grep -v secret  
```

Tambien se puede guardar sin esto '| nc localhost 30002 | grep -v Wrong | grep -v secret; done', meter en un diccionario el cat de la ejecucion del script y enviarle el diccionario asi:

```bash
cat diccionario.txt | nc localhost 30002 | grep -v Wrong | grep -v secret
```

---

## diff

Para ver las diferencias en los contenidos entre dos archivos:

```bash
diff archivo1 archivo2
```

Los ficheros que tiene asi: (se llama setuid)

```bash
-rwsr-x--- 1 bandit20 bandit19 14876 Apr 23 18:04 bandit20-do
```

Es que permiten al otro usuario ejecutar ese archivo de manera temporal, este permite que al ejecutar el programa nos permita ejeutar un comando como ese usuario, si le anadimos como argumento sh, nos spawneara una shell donde sneremos ese usuario, si hacemos bash no va, a no ser que hagamos bash -p, por temas de seguridad.

---

## cron

Las tareas cron son tareas repetitivas que se repiten en segundo plano, se pueden ver /etc/cron.d y despues podemos ver que hacen por dentro.

Si se ve esta estructura en una tarea cron (que se pueden ver con cat), es que se esta ejecutando un Script en /usr/bin/cronjob_bandit24.sh:

```bash
@reboot bandit24 /usr/bin/cronjob_bandit24.sh &> /dev/null
* * * * * bandit24 /usr/bin/cronjob_bandit24.sh &> /dev/null
```

Si quiero hashear (como encriptar) algun contenido: (los hashes solo ocultan informacion, pero se pueden usar como si fuese esa informacion, a veces y creo)

```bash
echo "Texto" | md5sum | cut -d ' ' -f 1 # Lo ultimo es para no ver el ' - ', tambien vale hacer awk '{print $1}'
```

En ocasiones puedo ver tareas recurrentes que ejecutan scripts en carpetas pero no puedo acceder a ellas. Si quiero sacar contenido puedo hacer un script y meterlo dentro de esa carpetas:

En el script tendria que poner:

```bash
cat /directorio_A_Entrar > /Directorio_Script_Mio/archivo_Donde_Info_Interes.txt
```

Ahora al directorio y al archivo hay que darle los siguientes permisos: (igual al archivo)

```bash
chmod 777 /Directorio_Script_Mio/
```

Y se copia con cp al directorio de interes:

```bash
cp ScriptMio.sh /Directorio_Script_Mio/ScriptMio.sh
```

Se hace que otros pueidan escribir en el directorio donde hicimos el Script para que nos de el .txt con la info:

```bash
chmod o+w /Directorio_Script_Mio/ 
```

Se hace un watch en nuestra carpeta, que lo que hace es monitorizar cada segundo que ocurre en ella, para cuando llegue el archivo con la info:

```bash
watch -n 1 ls /Directorio_Script_Mio/       # El 1 indica cada cuantos segundos
```

---

## git

Para ver el historial de commits de un repositorio en busca de info util:

```bash
git log -p
```

Si no encontramos podemos cambiar de rama con y hacer otro log (ver rama con git branch -r)

```bash
git checkout nombreRama
```

A veces se esconden cosas en los tags, para ver los tags:

```bash
git tag
```

Para ver el contenido de un tag:

```bash
git show nombreTag
```

Si al subir algo el .gitignore no molesta y somos propietaros, lo borramos y via.

Si una shell que no me deja hacer nada con letras, puedo hacer $0 y me movera a la shell de bash ya que es la 0.

---

## SSH 

Se ha ido a /etc/ssh/ssh_config y se ha habilitado el PermitRootLogin.

Para que nos acepten sin contrasena se puede hacer generando una key y despues con el id_rsa.pub, (que la .pub es la clave publica) se renombra a authorzed_keys y se mete en el /.ssh del servidor al que me quiero conertar sin que me pidan contrasena. 

Tambien se puede hacer haciendo, despues de generar la clave:

```bash
ssh-copy-id -i ~/.ssh/id_rsa usuario@ip
```

Tambien te puedes conectar directamente con el archivo privado (que tambien se puede llamar sshkey.private):

```bash
ssh -i sshkey.private usuario@ip
```

Podemos conertarnos a localhost de los equipos que conectaos a traves de ssh, tambien a traves de ssh a ver si hay otros usuarios o encontramos algo:

```bash
ssh otro_usuario_delServidorSSH@localhost
```

Si me dan la generacion de una key, la puedo meter en un fichero 'id_rsa' y cambiarle los privilegios a 600 y se podra usar ya para los comandos anteriores

Las conexiones ssh suelen tardar y podemos colar comandos y ver su output mientras cargan (cuando se ha puesto la contrasena correcta) antes de que nos eche (si nos tienen vetados o algo):

```bash
ssh usuario@ip comando1; comando2; comando3
```

Puedo aprovecharlo para spawnear una bassh y colarme y ejeuctar comandos (aunque no se vea nada, se puedn ejecutar comandos):

```bash
ssh usuario@ip bash
```

Si para conectarnos a ssh que nos echa y vemos que su shell es rara y miramos el archivo y hay un more podemos hacer mucho zoom en la terminal para estar dentro del paging del more y se rompa, hay si pulsamos v nos deja ejecutar comandos porque no nos ha echado debido al bug del more. Yo hago pequena la ventana de la aplicacion terminal. Si pulso v me deja escribir y si le pongo:

```bash
:set shell=/bin/bash

y luego

:shell
```

Y ya puedo agrandar y ya estoy en bash



