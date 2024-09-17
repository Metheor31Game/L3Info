console.log("Hello world");

type emoji = '🍎' | '🍌' | '🍒' | '🍓' | '🍇' | '🍉' | '🍊' | '🍍';

type carte = {
    symbole: emoji;
    etat: boolean; 
}

const symboles: Array<emoji> = ['🍎' , '🍌' , '🍒' , '🍓' , '🍇' , '🍉' , '🍊' , '🍍'];


function creerJeu(): Array<carte> {
    const cartes : Array<carte> = new Array<carte>;
    for (let i : number = 0; i < symboles.length; i++) {
        cartes.push({
            symbole: symboles[i],
            etat: false
        })
        cartes.push({
            symbole: symboles[i],
            etat: false
        })
    }
    return cartes.sort(() => Math.random() - 0.5);
}


function afficheCarte(cartes: Array<carte>) : void {
    document.body.innerHTML = "";
    
    //1 : créer un noeud
    const container = document.createElement('div');
    document.body.appendChild(container);
    container.classList.add('carte-container');

    //2parcourir les cartes et ajouter les divs correspondantes
    cartes.forEach(carte => {
        const carteElement = document.createElement('div');
        carteElement.classList.add('carte');
        carteElement.textContent = carte.etat ? carte.symbole : '';
        container.appendChild(carteElement);
    })
}


/**
 * Renvoie une `Promise` qui `resolve` quand une carte a été cliquée. Le contenu de la Promise est l'index de cette carte dans le tableau.
*/
type CardIndex = number;
async function clickOnCard(): Promise<CardIndex> {
    return new Promise((resolve) => {
        const listener = (event: MouseEvent) => {
            console.log(event.target);
            //@ts-ignore
			if (!event.target.classList.contains('carte')) {
                return;
			}
            //@ts-ignore
			const index = Array.from(event.target.parentNode.children).indexOf(
                event.target as HTMLElement
			);
			resolve(index);
			document.removeEventListener('click', listener);
		};
		document.addEventListener('click', listener);
	});
}

let jeuEnCour : Array<carte> = creerJeu();
async function boucleJeu() {
    while (true) {
        afficheCarte(jeuEnCour);
        const index = await clickOnCard();
        console.log(`Carte cliquée : ${index}`);
        jeuEnCour[index].etat = true;
    }
}

boucleJeu();