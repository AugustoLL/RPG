

Proyecto Videojuego RPG

Augusto Lombino

                                                                                                                                        



El videojuego fue
desarrollado usando el motor de videojuegos GodotEngine y usando el lenguaje
GDScript.



Repositorio: https://github.com/AugustoLL/RPG 



Se busca desarrollar un juego que
les permita a los usuarios crear sus propios personajes, los cuales podrán
mejorar cuando completen misiones que les brindara experiencia (XP). Las
misiones a su vez ofrecerán una historia para entretener a los jugadores. Todos
los assets usados son obtenidos de la tienda de godot y de una comunidad de
Reddit llamada r/freeAssets.



 



Estado Actual del Juego

 



Por el momento el juego solo
permite el uso de un personaje de estilo luchador, y todavía no se incluyen las
misiones u otros personajes que no sean enemigos. También solo se ha creado una
escena que se lo podría llamar el Nivel 1, en la cual el usuario solo puede
correr, esquivar y luchar contra los murciélagos. Ya se han agregado efectos de
sonido y una cámara que sigue al jugador. También se ha logrado que los
murciélagos colisionen entre ellos (este es un problema que tuve, ya que si 5
murciélagos comenzaban a seguir al personaje, los mismos no colisionaban con sí
mismos provocando que se mezclaran y pareciera que sólo un enemigo estaba
persiguiendo al jugador).



 



 





También como se muestra a continuación se ha logrado implementar “Estados” que el jugador y el
murciélago poseen. Por ejemplo, la siguiente imagen muestra los estados del
personaje principal. Se observa que existe Moverse, Esquivar y Atacar. Esto
antes de rendir el final quisiera modificarlo para poder hacer uso del Patrón de Estados, el cual “le permiten a un objeto alterar su
comportamiento cuando su estado interno cambia, de manera que el objeto parezca
cambiar de clase”.  En lugar de
depender de un switch (o en el caso de GDScript un match), se deberá crear una
clase para cada estado que implementen una interfaz en común. Entonces en mi
caso, tendría una clase para el movimiento, una para esquivar y una para
atacar, y las tres implementan una interfaz en común que les obliga a recibir
un input y a actualizar el estado por ejemplo.





 



Otra función que se debe implementar antes del final, es la
opción de que el jugador, en el inicio, tenga la opción de crear un personaje,
eligiendo entre guerrero, mago, paladín… En caso de que no se encuentren assets
gratuitos que cumplan la función que se necesita, los mismos serán creados
usando un programa llamado Aseprite, y luego serán importados a godot. También,
se buscará implementar una pantalla de inicio y una de “Game Over”, que se
muestre cuando al jugador se le acaben las vidas.





También, como se detalló en el
informe del videojuego, en un futuro se buscará implementar más mapas a través
de los cuales los jugadores puedan viajar, cada uno con distintos tipos de
enemigos y por ejemplo, con distintos assets, por ejemplo uno en una playa,
otro en una zona montañosa. También se buscará remplazar el sistema de vidas
actual, y cambiarlo por una sistema que te brinde experiencia a medida que se
van completando misiones y matando enemigos. En conjunto con este informe, y
las imágenes que se encuentran en el mismo. Se incluye en la carpeta de entrega
un video que muestra el funcionamiento del juego y además se incluye una
carpeta RPG, que contiene el proyecto entero y un ejecutable RPG.exe, el cual
muestra la demo actual del juego.



