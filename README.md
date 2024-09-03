# 🚗 Mission Go Fast - Script FiveM

Bienvenue dans **Mission Go Fast**, un script personnalisé pour [FiveM](https://fivem.net) conçu pour le framework **ESX**. Ce script ajoute une nouvelle dimension de jeu à votre serveur en permettant aux joueurs d'effectuer des livraisons rapides tout en évitant la police et les obstacles sur leur chemin.

## 🚀 Fonctionnalités

- **Mission de Go Fast** : Les joueurs peuvent initier une mission en rencontrant un contact spécifique sur la carte. Ils doivent ensuite récupérer un véhicule et transporter un colis à haute vitesse tout en évitant les forces de l'ordre.
- **Marqueur GPS dynamique** : Une fois la mission commencée, un itinéraire est indiqué sur le GPS du joueur pour lui montrer le chemin vers le point de livraison.
- **Déduction automatique d'argent** : Le joueur doit payer une somme initiale pour participer à la mission. Cette somme est automatiquement déduite de son compte.
- **Scène immersive** : À l'arrivée, une scène se déclenche où des PNJs réceptionnent la marchandise, ajoutant un niveau de réalisme supplémentaire.
- **Optimisé pour ESX** : Intégration parfaite avec le framework ESX pour une expérience fluide et cohérente.

## 📦 Installation

Pour installer ce script sur votre serveur FiveM :

1. **Téléchargez** ou **clonez** ce dépôt dans le répertoire `resources` de votre serveur FiveM.
2. Renommez le dossier en `pipax_gofast` si ce n'est pas déjà fait.
3. Ajoutez la ligne suivante à votre fichier `server.cfg` pour démarrer le script :

    ```bash
    start pipax_gofast
    ```

4. **Redémarrez** votre serveur FiveM pour appliquer les modifications.

## 🎮 Utilisation

1. **Rendez-vous** au point de rencontre du contact (la position peut être modifiée dans le fichier `client/client.lua`).
2. **Appuyez sur `E`** pour interagir avec le contact et commencer la mission Go Fast pour une somme de **1000$**.
3. Suivez le **marqueur GPS** pour atteindre le point de livraison tout en évitant les forces de l'ordre et les autres dangers.

## 🔧 Configuration

Vous pouvez personnaliser plusieurs aspects du script :

- **Emplacement du contact** : Modifiez les coordonnées dans le fichier `client/client.lua` pour placer le contact à l'endroit souhaité.
- **Coût de la mission** : Ajustez la variable de coût dans le fichier `server/server.lua`.
- **Apparence des PNJs** : Changez le modèle des PNJs dans `client/client.lua` pour utiliser d'autres modèles disponibles.

## 🚫 Règles d'Utilisation

⚠️ **Il est strictement interdit de revendre ou distribuer ce script. Ce script est la propriété exclusive de son auteur et ne peut être vendu que par lui-même ou sous licence autorisée. Toute infraction à cette règle pourra entraîner des poursuites légales.**

## 🔔 Mises à Jour et Support

Pour toutes les informations, mises à jour, ou support concernant ce script, veuillez nous rejoindre sur **Discord** [https://discord.gg/FXTuCZdCkY].

## ✨ Auteur

Développé avec ❤️ par PIPAX91. Contributions et suggestions sont les bienvenues !

## 📜 Licence

Ce projet est sous licence [MIT](https://opensource.org/licenses/MIT). Utilisation non commerciale uniquement. Pour toute question de licence, veuillez consulter notre page Discord.

---

*Merci d'utiliser ce script pour enrichir l'expérience de jeu sur votre serveur FiveM. Nous espérons que vous apprécierez cette aventure palpitante de Go Fast !* 🎉
