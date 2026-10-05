# Simple Gradle Java APP
Simple Java App Created with Gradle

Please read this Article to make the best use of this git repo

[https://adityasridhar.com/posts/how-to-get-started-with-gradle](https://adityasridhar.com/posts/how-to-get-started-with-gradle)

## Cloning the Code

Clone this code into your local using the following command

`git clone https://github.com/aditya-sridhar/simple-gradle-java-app.git`

## Building the Application 

The application can be built using the following command 

**Windows** : `gradlew.bat build`

**Linux/MacOS**: `./gradlew build`

## Running the Application

The application can be run using the following command 

**Windows** : `gradlew.bat run`

**Linux/MacOS**: `./gradlew run`

## Tests

After the Application is built using the Build command, the test results report can be found in below file
*build/reports/tests/test/index.html*
---

# TP Git - Réponses

## 1. Différence entre un dépôt local et un dépôt distant

Un dépôt local est un dépôt Git présent sur la machine du développeur. Il permet
de modifier les fichiers, créer des commits et consulter l'historique du projet.

Un dépôt distant (remote) est un dépôt utilisé comme point de partage entre
plusieurs développeurs. Les développeurs peuvent y envoyer leurs commits avec
`git push` et récupérer les modifications avec `git fetch` ou `git pull`.

## 2. Dépôt remote bare

Le dépôt `$REMOTE` a été créé avec la commande :

`git init --bare`

Un dépôt bare ne possède pas de copie de travail (working tree). Il contient
l'historique Git, les objets et les références, et peut servir de dépôt central
pour partager les commits entre plusieurs développeurs.

## 3. Observation après le premier push

Après le premier `git push` de DEV1 vers `$REMOTE`, les commits sont présents
dans le dépôt distant. Cependant, les fichiers du projet ne sont pas directement
visibles comme dans DEV1 car `$REMOTE` est un dépôt bare.

## 4. DEV1, DEV2 et REMOTE

DEV1 et DEV2 sont deux dépôts locaux indépendants.

Le dépôt `$REMOTE` sert d'intermédiaire entre les deux développeurs :

`DEV1 <-> REMOTE <-> DEV2`

Chaque développeur possède sa propre branche locale et peut envoyer ou récupérer
des modifications depuis le dépôt distant.

## 5. git fetch

La commande `git fetch` récupère les nouveaux commits présents sur le dépôt
distant et met à jour les références distantes comme `origin/master`.

Elle ne modifie pas la branche locale `master` ni les fichiers de travail.

Nous avons ainsi constaté que `origin/master` pouvait pointer sur le nouveau
commit de DEV1 alors que `HEAD -> master` de DEV2 restait sur l'ancien commit.

## 6. git pull

La commande `git pull` permet de récupérer les modifications du dépôt distant
et de les intégrer dans la branche locale.

Contrairement à `git fetch` seul, les fichiers de la copie de travail peuvent
donc être mis à jour après un `git pull`.

## 7. Gestion des conflits

Au cours du TP, nous avons rencontré deux conflits différents dans le fichier
`App.java`.

### Premier conflit : modification du calcul de la somme

DEV1 et DEV2 ont modifié la même partie de la méthode `getSum()` à partir d'un
historique commun.

DEV1 avait modifié le calcul en utilisant :

`return num2+num1;`

De son côté, DEV2 avait modifié la même zone en utilisant une variable
intermédiaire :

`int somme = num1+num2;`

`return somme;`

DEV2 a ensuite récupéré les nouveaux commits de DEV1 avec `git fetch`. Le
`git lol` a permis de constater que les historiques de DEV1 et DEV2 avaient
divergé.

Lors du `git merge origin/master`, Git n'a pas pu fusionner automatiquement
les deux modifications puisqu'elles concernaient la même zone du fichier.
Un conflit a donc été signalé.

Git a affiché les deux versions avec les marqueurs :

`<<<<<<< HEAD`

`=======`

`>>>>>>> origin/master`

Dans ce cas, `HEAD` représentait la version locale de DEV2 et
`origin/master` représentait la modification provenant de DEV1.

Nous avons résolu manuellement le conflit en conservant la version utilisant
la variable `somme`. Les marqueurs de conflit ont ensuite été supprimés.

Le fichier résolu a été ajouté avec `git add`, puis la fusion a été validée
avec un commit de merge et propagée vers `$REMOTE` avec `git push`.

### Deuxième conflit : modification de l'auteur

Un deuxième conflit a été provoqué sur l'information `@author` du fichier
`App.java`.

DEV1 a ajouté/modifié l'auteur avec :

`@author DEV1`

et a propagé cette modification vers `$REMOTE`.

De son côté, DEV2 a modifié la même information avec :

`@author DEV2`

Les deux développeurs avaient donc effectué des modifications différentes sur
la même ligne du même fichier.

Lors de la récupération et de la fusion des modifications, Git n'a pas pu
choisir automatiquement entre `DEV1` et `DEV2`. Un nouveau conflit est donc
apparu.

Le conflit a été résolu manuellement en choisissant :

`@author DEV2`

Après suppression des marqueurs de conflit, le fichier a été ajouté avec
`git add`, puis un nouveau commit de résolution a été créé et propagé vers
`$REMOTE`.

Enfin, DEV1 a effectué un `git pull` afin de récupérer cette résolution.

Après cette opération, DEV1, DEV2 et `$REMOTE` se sont retrouvés dans le même
état.

### Conclusion sur les conflits

Ces deux expériences montrent qu'un conflit Git apparaît lorsque Git ne peut
pas déterminer automatiquement quelle modification doit être conservée.

La résolution nécessite alors une intervention du développeur : il faut
examiner les différentes versions, choisir ou combiner le contenu souhaité,
supprimer les marqueurs de conflit, utiliser `git add`, terminer la fusion par
un commit, puis partager le résultat avec `git push`.

## 8. Commit de merge

Après la résolution du conflit, Git a créé un commit de merge possédant deux
parents. Ce commit réunit les historiques provenant de DEV1 et DEV2.

Le commit de merge a ensuite été envoyé vers `$REMOTE` avec `git push`.

## 9. Synchronisation finale

Après la résolution des conflits et la propagation des modifications, DEV1,
DEV2 et `$REMOTE` ont été synchronisés afin de partager le même historique Git.
