Jeux SpaceRace
==============

Auteur : Nicolas Bisson et Étienne Drolet
Date : 2016-05-26
Version : 1.6
Langage : Eiffel
IDE : EiffelStudio

--------------------------------------------------------------------------------

Résumé:
	SpaceRace est un jeu de course contre la montre. Il y a quatre(4) modèles 
	de pistes et trois(3) modèles de vaisseaux disponibles. Le jeux est simple, 
	il suffit simplement de terminer le nombre de tours requis le plus 
	rapidement possible en passant par tous les terminus pour pouvoir compléter 
	un tour. Le temps pourra alors être enregistré dans le tableau des meneurs 
	avec votre nom.

--------------------------------------------------------------------------------

Instructions:
	Pour pouvoir avoir accès au classement des scores ou pour s'y inscrire, 
	le serveur doit être ouvert. Il suffit de lancer l'application 
	serveur_spacerace à l'aide d'EiffelStudio pour le démarrer.

	La navigation des menus se fait avec la souris.
	
	Les touches W, A, S et D sont les touches pour avancer, pivoter et freiner.

--------------------------------------------------------------------------------

Installation:
	Windows
		1.	Installer EiffelStudio
			a.	Télécharger EiffelStudio à l’adresse suivante : 
				https://sourceforge.net/projects/eiffelstudio/files/EiffelStudio%2015.12/Build_98308/
			b.	Exécuter l’installation du logiciel.
		2.	Installer Eiffel Game 2
			a.	Télécharger Eiffel Game 2 à l’adresse suivante : 
				https://github.com/tioui/Eiffel_Game2/tree/windows_build 
			b.	Copier le répertoire nommé « game2 » dans le sous-répertoire 
				d’EiffelStudio contrib/library/
		3.	Copier les fichiers .dll du fichier .zip dans le répertoire du projet. 
			Prenez les .dll correspondant à votre version d’EiffelStudio (DLL32.zip ou DLL64.zip).
		4.	Copier le répertoire « mingw » dans le répertoire 
			EiffelStudio/EiffelStudio 15.11 GPL/unstable/library/persistency/database/sqlite3/spec
		5.	Lancer l’application à l’aide d’EiffelStudio
		
	Linux
		1.	Installer EiffelStudio
			a.	# sudo add-apt-repository ppa:eiffelstudio-team/ppa
			b.	# sudo apt-get update
			c.	# sudo apt-get install eiffelstudio
		2.	Installer les librairies C
			a.	# sudo apt-get install git libopenal-dev libsndfile1-dev libgles2-mesa-dev
			b.	# sudo apt-get install git libsdl2-dev libsdl2-gfx-dev libsdl2-image-dev libsdl2-ttf-dev
			c.	# sudo apt-get install libepoxy-dev libgl1-mesa-dev libglu1-mesa-dev
		3.	Télécharger Eiffel Game 2
			a.	# git clone https://github.com/tioui/Eiffel_Game2.git
		4.	Créer un lien entre le répertoire EiffelStudio et Eiffel_Game2
			a.	# sudo ln –s `pwd`/Eiffel_Game2/usr/lib/eiffelstudio-15.12/contrib/library
		5.	Compiler la librairie
			a.	# cd Eiffel_Game2
			b.	# ./compile_c_library.sh
		6.	Lancer l’application à l’aide d’EiffelStudio
			
--------------------------------------------------------------------------------

License:
	Copyright (c) 2015 Nicolas Bisson & Étienne Drolet

    L'autorisation est accordée, gracieusement, à toute personne acquérant une
    copie de ce programme et des fichiers de documentation associés
    (le "Programme"), de commercialiser le Programme sans restriction,
    notamment les droits d'utiliser, de copier, de modifier, de fusionner, de
    publier, de distribuer, de sous-licencier et / ou de vendre des copies de
    le Programme, ainsi que d'autoriser les personnes auxquelles le
    Programme est fourni à le faire, sous réserve des conditions suivantes:

    La déclaration de copyright ci-dessus et la présente autorisation doivent
    être incluses dans toutes copies ou parties substantielles du
    Programme.

    LE PROGRAMME EST FOURNI "TEL QUEL", SANS GARANTIE D'AUCUNE SORTE,
    EXPLICITE OU IMPLICITE, NOTAMMENT SANS GARANTIE DE QUALITÉ MARCHANDE,
    D’ADÉQUATION À UN USAGE PARTICULIER ET D'ABSENCE DE CONTREFAÇON. EN AUCUN
    CAS, LES AUTEURS OU TITULAIRES DU DROIT D'AUTEUR NE SERONT RESPONSABLES DE
    TOUT DOMMAGE, RÉCLAMATION OU AUTRE RESPONSABILITÉ, QUE CE SOIT DANS LE
    CADRE D'UN CONTRAT, D'UN DÉLIT OU AUTRE, EN PROVENANCE DE, CONSÉCUTIF À OU
    EN RELATION AVEC LA BIBLIOTHÈQUE OU SON UTILISATION, OU AVEC D'AUTRES
    ÉLÉMENTS DE LA BIBLIOTHÈQUE.
	
	NB.:
		- Le vaisseau du logo n'est pas une création originale et 
		viens de : 
		http://thumbs.dreamstime.com/z/cartoon-spaceship-icon-22913758.jpg
		
		- Le fond d'écran n'est pas une création originale (nous n'avons plus
		la source malheureusement...)
		
		- Le son d'un click n'est pas une création originale, mais il a été 
		quelques peu modifié. Il viens de : https://youtu.be/4GFNjLpdPic
		
		- La musique n'est pas une création originale et viens de :
		https://youtu.be/d64hr3swPLA
		
		- Le son de vaisseau n'est pas une création originale, mais il a été
		quelques peu modifié. Il viens de :	https://youtu.be/ZMV0GGTbnbU