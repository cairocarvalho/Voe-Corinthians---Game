import processing.sound.*;
SoundFile music;
SoundFile pulo;
//utilizando a biblioteca do proprio processing de audio, foi criado duas variaveis music e pulo.//
 
PImage backpic, gaviao, wallpic, bemvindos;
  //criado as variaveis, highscore é utilizada para a melhor pontuação do jogo "recorde" e score para pontuação dentro da sala in game.//
  //backpic é o background utilizado ao fundo, gaviao é para o passaro, wallpic são os canos de obstaculo e a tela de inicio como bemvindos//

int game, score, highscore, x, y, vertical, wallx[] = new int[2], wally[] =new int[2];
//variaveis do jogo conforme explicado, e aqui chamamos x y para posionamento do gaviao.//
// vertical é muito importante pois ela determina a movimentação do gaviao//
//wallx e wally são utilizadas para a criação dos obstaculos//

void setup() {
  backpic =loadImage("back.png");
  gaviao =loadImage("bird.png");
  wallpic =loadImage("wall.png");
  bemvindos=loadImage("start.png");
  // carregamento das imagens utilizadas e abaixo game 0 para chamar o inicio e 1 para tela de inicio//
  game = 1;
  score = 0;
  highscore = 0;
  x = -200;
  vertical = 0;
  size(600, 800);
  fill(0, 0, 0);
  textSize(20);
  music = new SoundFile(this, "efeito.mp3");
  pulo = new SoundFile(this, "pulo.mp3");
  music.play();
 //aqui chamamos os efeitos sonoro, o primeiro na tela de inicio //
}
void draw() {
  if (game == 0) {
    imageMode(CORNER); 
    //imagem de background foi colocada duas vezes para se repetir no cenario de fundo. CORNER é utilizado para mostrar o lado que a tela "anda"//
    image(backpic, x, 0);
    image(backpic, x+backpic.width, 0);
    //aqui setado a repetição de imagem e width para a imagem ser cortada um pouco para esquerda intensificando a ilusão de que o gaviao esta em movimento//
    // o x abaixo é a velocidade que o fundo se move//
    x -= 5;
    vertical += 1;
    y += vertical;
    // o pulo do gaviao infinitamente e o jogo continuar
    if (x == -1800) x = 0;
    for (int i = 0; i < 2; i++) {
      imageMode(CENTER);
      image(wallpic, wallx[i], wally[i] - (wallpic.height/2+100));
      image(wallpic, wallx[i], wally[i] + (wallpic.height/2+100));
      //utilizada a estrutura para repetir os obstaculos e criar sempre ao centro da tela - + representando para sup e inf.//
      if (wallx[i] < 0) {
        wally[i] = (int)random(200, height-200);
        wallx[i] = width;
        //criamos os obstaculos randomicos, para aparecer de diversos tamanhos tornando o jogo mais dificil quando alternamos obstaculos pequenos e grandes//
      }
      if (wallx[i] == width/2) highscore = max(++score, highscore);
      // aqui a utilização do recorde para mostrar sempre a maior pontuação ao jogo
      
      if (y>height||y<0||(abs(width/2-wallx[i])<25 && abs(y-wally[i])>100)) game=1;
      //sistema de colisao para que o gaviao "morra" assim que bater em um obstaculo ou sair da tela de jogo, retornando ao inicio com game=1//
      //abs calcula o valor absoluto para retornar o sistema de colisao
      
      wallx[i] -= 6;
      //utilizamos para que a parede tambem se mova para direita
    }
    image(gaviao, width/2, y);
    text("Pontuação: "+score, 10, 20);
    fill(255, 255, 252);
  // desenho do gaviao e o texto de pontuação no superior
  } else {
    imageMode(CENTER);
    image(bemvindos, width/2, height/2);
    text("Recorde: "+highscore, 10, 50);
    fill(255, 255, 252);
    // tela de inicio com a pontuacao recorde no superior
  }
}
void mousePressed() {
  vertical = -15;
  if (game==1) {
    wallx[0] = 600;
    wally[0] = y = height/2;
    wallx[1] = 900;
    wally[1] = 600;
    x = game = score = 0;
  //Quando pressionamos o mouse o jogo se inicia e com o mouse também controlamos o gaviao, reduzindo vertical.
  }
  pulo.play();
  //setado para o efeito de pulo quando pressionarmos o mouse para controle do gaviao
}
