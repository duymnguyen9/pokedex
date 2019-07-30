import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomTabRoundedCorner extends StatelessWidget {
  const BottomTabRoundedCorner({Key key, this.pokemonColor}) : super(key: key);
  final Color pokemonColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.getInstance().setHeight(70),
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Container(
            height: ScreenUtil.getInstance().setHeight(70),
            width: MediaQuery.of(context).size.width,
            color: pokemonColor,
          ),
          Container(
            height: ScreenUtil.getInstance().setHeight(47),
            width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                color: Color(0xFFFAFAFA),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(ScreenUtil().setHeight(45)),
                    bottomRight: Radius.circular(ScreenUtil().setHeight(45))))
            )
        ],
      ),
    );
  }
}

void screenSizeStatus(String widgetname, BuildContext context) {
  print(widgetname);
  if (ScreenUtil.getInstance().height == 812.0) {
    print("screenSizeStatus: matches!");
  } else {
    print("screen height is " + MediaQuery.of(context).size.height.toString());
    print("iphoneX height supposed to be 812: " +
        ScreenUtil.getInstance().height.toString());
    print("If this is not iphone X, value of 25 is: " +
        (ScreenUtil.getInstance().setWidth(25)).toString());
  }
}

void screenSizeConfiguration(
    BuildContext context, double screenwidth, double screenHeight) {
  ScreenUtil.instance = ScreenUtil(
    width: screenwidth,
    height: screenHeight,
    allowFontScaling: true,
  )..init(context);
  print("default Screen Height: " + ScreenUtil.getInstance().height.toString());
  print(
      "actual Screen Height: " + MediaQuery.of(context).size.height.toString());
}

class PokemonPageUltility {
  final Pokemon pokemon;

  String getPrimaryType() =>
      pokemon.types.firstWhere((type) => type.slot == 1).typeName;

  Gradient pokemonColorGradient() {
    return pokemonColorsGradient[getPrimaryType().toLowerCase()];
  }

  Color pokemonColor() => pokemonColors[getPrimaryType().toLowerCase()];


  String getPokemonTypeDirectory() {
    String baseDirectory = 'assets/img/tag/';
    return baseDirectory + getPrimaryType() + '.png';
  }

  PokemonPageUltility(this.pokemon);
}



Map<String, Gradient> pokemonColorsGradient = {
  "grass": LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: [
        0.0,
        1.0
      ],
      colors: [
        const Color(0xff5FBC51),
        const Color(0xff5AC178),
      ]),
  "water": LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: [
        0.38,
        0.68
      ],
      colors: [
        const Color(0xff559EDF),
        const Color(0xff69B9E3),
      ]),
  "bug": LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: [
        0.1,
        0.7
      ],
      colors: [
        const Color(0xff92BC2C),
        const Color(0xffAFC836),
      ]),
  "dark": LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: [
        0.1,
        0.7
      ],
      colors: [
        const Color(0xff595761),
        const Color(0xff6E7587),
      ]),
  "dragon": LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: [
        0.1,
        0.7
      ],
      colors: [
        const Color(0xff0C69C8),
        const Color(0xff0180C7),
      ]),
  "electric": LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: [
        0.1,
        0.7
      ],
      colors: [
        const Color(0xffEDD53E),
        const Color(0xffFBE273),
      ]),
  "fairy": LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: [
        0.1,
        0.7
      ],
      colors: [
        const Color(0xffEC8CE5),
        const Color(0xffF3A7E7),
      ]),
  "fighting": LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: [
        0.1,
        0.7
      ],
      colors: [
        const Color(0xffCE4265),
        const Color(0xffE74347),
      ]),
  "fire": LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: [
        0.1,
        0.7
      ],
      colors: [
        const Color(0xffFB9B51),
        const Color(0xffFBAE46),
      ]),
  "flying": LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: [
        0.1,
        0.7
      ],
      colors: [
        const Color(0xff90A7DA),
        const Color(0xffA6C2F2),
      ]),
  "ghost": LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: [
        0.1,
        0.7
      ],
      colors: [
        const Color(0xff516AAC),
        const Color(0xff7773D4),
      ]),
  "ground": LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: [
        0.1,
        0.7
      ],
      colors: [
        const Color(0xffDC7545),
        const Color(0xffD29463),
      ]),
  "ice": LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: [
        0.1,
        0.7
      ],
      colors: [
        const Color(0xff70CCBD),
        const Color(0xff8CDDD4),
      ]),
  "normal": LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: [
        0.1,
        0.7
      ],
      colors: [
        const Color(0xff9298A4),
        const Color(0xffA3A49E),
      ]),
  "poison": LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: [
        0.1,
        0.7
      ],
      colors: [
        const Color(0xffA864C7),
        const Color(0xffC261D4),
      ]),
  "psychic": LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: [
        0.1,
        0.7
      ],
      colors: [
        const Color(0xffF66F71),
        const Color(0xffFE9F92),
      ]),
  "rock": LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: [
        0.1,
        0.7
      ],
      colors: [
        const Color(0xffC5B489),
        const Color(0xffD7CD90),
      ]),
  "steel": LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: [
        0.1,
        0.7
      ],
      colors: [
        const Color(0xff52869D),
        const Color(0xff58A6AA),
      ]),
};

Map<String, Color> pokemonColors = {
  "grass": Color(0xFF5DBE62),
  "water": Color(0xFF559EDF),
  "bug": Color(0xFF9DC130),
  "dark": Color(0xFF5F606D),
  "dragon": Color(0xFF5F606D),
  "electric": Color(0xFFEDD53F),
  "fairy": Color(0xFFEF97E6),
  "fighting": Color(0xFFD94256),
  "fire": Color(0xFFF8A54F),
  "flying": Color(0xFF9BB4E8),
  "ghost": Color(0xFF6970C5),
  "ground": Color(0xFFD78555),
  "ice": Color(0xFF7ED4C9),
  "normal": Color(0xFF9A9DA1),
  "poison": Color(0xFFB563CE),
  "psychic": Color(0xFFF87C7A),
  "rock": Color(0xFFCEC18C),
  "steel": Color(0xFF5596A4),
};

Map<String, String> pokemonStatTypesMap = {
  "hp": "HP",
  "attack": "ATK",
  "defense": "DEF",
  "special-attack": "SATK",
  "special-defense": "SDEF",
  "speed": "SPD",
};

class PokeballLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: buildAnimation());
  }

  final tween = MultiTrackTween([
    Track("rotation").add(Duration(seconds: 1), Tween(begin: 0.0, end: 0.2),
        curve: Curves.bounceInOut)
  ]);

  Widget buildAnimation() {
    return ControlledAnimation(
      playback: Playback.LOOP,
      duration: tween.duration,
      tween: tween,
      builder: (context, animation) {
        return Transform.rotate(
          angle: animation["rotation"],
          child: Container(
              child: Image.asset(
            "assets/img/pokeball_img_load.png",
            width: 50,
            height: 50,
          )),
        );
      },
    );
  }
}

String upperCaseEveryWords(String inputText) {
  List<String> wordList = inputText.split(' ');
  List<String> outputWords = [];

  for (var word in wordList) {
    outputWords.add(word[0].toUpperCase() + word.substring(1));
  }
  return outputWords.join(' ');
}

Map<String, String> pokemonMovesWithType = {
  '10,000,000voltthunderbolt': 'electric',
  'absorb': 'grass',
  'accelerock': 'rock',
  'acid': 'poison',
  'acidarmor': 'poison',
  'aciddownpour': 'poison',
  'acidspray': 'poison',
  'acrobatics': 'flying',
  'acupressure': 'normal',
  'aerialace': 'flying',
  'aeroblast': 'flying',
  'afteryou': 'normal',
  'agility': 'psychic',
  'aircutter': 'flying',
  'airslash': 'flying',
  'alloutpummeling': 'fighting',
  'allyswitch': 'psychic',
  'amnesia': 'psychic',
  'anchorshot': 'steel',
  'ancientpower': 'rock',
  'aquajet': 'water',
  'aquaring': 'water',
  'aquatail': 'water',
  'armthrust': 'fighting',
  'aromatherapy': 'grass',
  'aromaticmist': 'fairy',
  'assist': 'normal',
  'assurance': 'dark',
  'astonish': 'ghost',
  'attackorder': 'bug',
  'attract': 'normal',
  'aurasphere': 'fighting',
  'aurorabeam': 'ice',
  'auroraveil': 'ice',
  'autotomize': 'steel',
  'avalanche': 'ice',
  'babydolleyes': 'fairy',
  'baddybad': 'dark',
  'banefulbunker': 'poison',
  'barrage': 'normal',
  'barrier': 'psychic',
  'batonpass': 'normal',
  'beakblast': 'flying',
  'beatup': 'dark',
  'belch': 'poison',
  'bellydrum': 'normal',
  'bestow': 'normal',
  'bide': 'normal',
  'bind': 'normal',
  'bite': 'dark',
  'blackholeeclipse': 'dark',
  'blastburn': 'fire',
  'blazekick': 'fire',
  'blizzard': 'ice',
  'block': 'normal',
  'bloomdoom': 'grass',
  'blueflare': 'fire',
  'bodyslam': 'normal',
  'boltstrike': 'electric',
  'boneclub': 'ground',
  'bonerush': 'ground',
  'bonemerang': 'ground',
  'boomburst': 'normal',
  'bounce': 'flying',
  'bouncybubble': 'water',
  'bravebird': 'flying',
  'breakneckblitz': 'normal',
  'brickbreak': 'fighting',
  'brine': 'water',
  'brutalswing': 'dark',
  'bubble': 'water',
  'bubblebeam': 'water',
  'bugbite': 'bug',
  'bugbuzz': 'bug',
  'bulkup': 'fighting',
  'bulldoze': 'ground',
  'bulletpunch': 'steel',
  'bulletseed': 'grass',
  'burnup': 'fire',
  'buzzybuzz': 'electric',
  'calmmind': 'psychic',
  'camouflage': 'normal',
  'captivate': 'normal',
  'catastropika': 'electric',
  'celebrate': 'normal',
  'charge': 'electric',
  'chargebeam': 'electric',
  'charm': 'fairy',
  'chatter': 'flying',
  'chipaway': 'normal',
  'circlethrow': 'fighting',
  'clamp': 'water',
  'clangingscales': 'dragon',
  'clangoroussoulblaze': 'dragon',
  'clearsmog': 'poison',
  'closecombat': 'fighting',
  'coil': 'poison',
  'cometpunch': 'normal',
  'confide': 'normal',
  'confuseray': 'ghost',
  'confusion': 'psychic',
  'constrict': 'normal',
  'continentalcrush': 'rock',
  'conversion': 'normal',
  'conversion2': 'normal',
  'copycat': 'normal',
  'coreenforcer': 'dragon',
  'corkscrewcrash': 'steel',
  'cosmicpower': 'psychic',
  'cottonguard': 'grass',
  'cottonspore': 'grass',
  'counter': 'fighting',
  'covet': 'normal',
  'crabhammer': 'water',
  'craftyshield': 'fairy',
  'crosschop': 'fighting',
  'crosspoison': 'poison',
  'crunch': 'dark',
  'crushclaw': 'normal',
  'crushgrip': 'normal',
  'curse': 'ghost',
  'cut': 'normal',
  'darkpulse': 'dark',
  'darkvoid': 'dark',
  'darkestlariat': 'dark',
  'dazzlinggleam': 'fairy',
  'defendorder': 'bug',
  'defensecurl': 'normal',
  'defog': 'flying',
  'destinybond': 'ghost',
  'detect': 'fighting',
  'devastatingdrake': 'dragon',
  'diamondstorm': 'rock',
  'dig': 'ground',
  'disable': 'normal',
  'disarmingvoice': 'fairy',
  'discharge': 'electric',
  'dive': 'water',
  'dizzypunch': 'normal',
  'doomdesire': 'steel',
  'doublehit': 'normal',
  'doubleironbash': 'steel',
  'doublekick': 'fighting',
  'doubleslap': 'normal',
  'doubleteam': 'normal',
  'doubleedge': 'normal',
  'dracometeor': 'dragon',
  'dragonascent': 'flying',
  'dragonbreath': 'dragon',
  'dragonclaw': 'dragon',
  'dragondance': 'dragon',
  'dragonhammer': 'dragon',
  'dragonpulse': 'dragon',
  'dragonrage': 'dragon',
  'dragonrush': 'dragon',
  'dragontail': 'dragon',
  'drainpunch': 'fighting',
  'drainingkiss': 'fairy',
  'dreameater': 'psychic',
  'drillpeck': 'flying',
  'drillrun': 'ground',
  'dualchop': 'dragon',
  'dynamicpunch': 'fighting',
  'earthpower': 'ground',
  'earthquake': 'ground',
  'echoedvoice': 'normal',
  'eerieimpulse': 'electric',
  'eggbomb': 'normal',
  'electricterrain': 'electric',
  'electrify': 'electric',
  'electroball': 'electric',
  'electroweb': 'electric',
  'embargo': 'dark',
  'ember': 'fire',
  'encore': 'normal',
  'endeavor': 'normal',
  'endure': 'normal',
  'energyball': 'grass',
  'entrainment': 'normal',
  'eruption': 'fire',
  'explosion': 'normal',
  'extrasensory': 'psychic',
  'extremeevoboost': 'normal',
  'extremespeed': 'normal',
  'facade': 'normal',
  'fairylock': 'fairy',
  'fairywind': 'fairy',
  'fakeout': 'normal',
  'faketears': 'dark',
  'falseswipe': 'normal',
  'featherdance': 'flying',
  'feint': 'normal',
  'feintattack': 'dark',
  'fellstinger': 'bug',
  'fierydance': 'fire',
  'finalgambit': 'fighting',
  'fireblast': 'fire',
  'firefang': 'fire',
  'firelash': 'fire',
  'firepledge': 'fire',
  'firepunch': 'fire',
  'firespin': 'fire',
  'firstimpression': 'bug',
  'fissure': 'ground',
  'flail': 'normal',
  'flameburst': 'fire',
  'flamecharge': 'fire',
  'flamewheel': 'fire',
  'flamethrower': 'fire',
  'flareblitz': 'fire',
  'flash': 'normal',
  'flashcannon': 'steel',
  'flatter': 'dark',
  'fleurcannon': 'fairy',
  'fling': 'dark',
  'floatyfall': 'flying',
  'floralhealing': 'fairy',
  'flowershield': 'fairy',
  'fly': 'flying',
  'flyingpress': 'fighting',
  'focusblast': 'fighting',
  'focusenergy': 'normal',
  'focuspunch': 'fighting',
  'followme': 'normal',
  'forcepalm': 'fighting',
  'foresight': 'normal',
  'forestscurse': 'grass',
  'foulplay': 'dark',
  'freezeshock': 'ice',
  'freezedry': 'ice',
  'freezyfrost': 'ice',
  'frenzyplant': 'grass',
  'frostbreath': 'ice',
  'frustration': 'normal',
  'furyattack': 'normal',
  'furycutter': 'bug',
  'furyswipes': 'normal',
  'fusionbolt': 'electric',
  'fusionflare': 'fire',
  'futuresight': 'psychic',
  'gastroacid': 'poison',
  'geargrind': 'steel',
  'gearup': 'steel',
  'genesissupernova': 'psychic',
  'geomancy': 'fairy',
  'gigadrain': 'grass',
  'gigaimpact': 'normal',
  'gigavolthavoc': 'electric',
  'glaciate': 'ice',
  'glare': 'normal',
  'glitzyglow': 'psychic',
  'grassknot': 'grass',
  'grasspledge': 'grass',
  'grasswhistle': 'grass',
  'grassyterrain': 'grass',
  'gravity': 'psychic',
  'growl': 'normal',
  'growth': 'normal',
  'grudge': 'ghost',
  'guardsplit': 'psychic',
  'guardswap': 'psychic',
  'guardianofalola': 'fairy',
  'guillotine': 'normal',
  'gunkshot': 'poison',
  'gust': 'flying',
  'gyroball': 'steel',
  'hail': 'ice',
  'hammerarm': 'fighting',
  'happyhour': 'normal',
  'harden': 'normal',
  'haze': 'ice',
  'headcharge': 'normal',
  'headsmash': 'rock',
  'headbutt': 'normal',
  'healbell': 'normal',
  'healblock': 'psychic',
  'healorder': 'bug',
  'healpulse': 'psychic',
  'healingwish': 'psychic',
  'heartstamp': 'psychic',
  'heartswap': 'psychic',
  'heatcrash': 'fire',
  'heatwave': 'fire',
  'heavyslam': 'steel',
  'helpinghand': 'normal',
  'hex': 'ghost',
  'hiddenpower': 'normal',
  'highhorsepower': 'ground',
  'highjumpkick': 'fighting',
  'holdback': 'normal',
  'holdhands': 'normal',
  'honeclaws': 'dark',
  'hornattack': 'normal',
  'horndrill': 'normal',
  'hornleech': 'grass',
  'howl': 'normal',
  'hurricane': 'flying',
  'hydrocannon': 'water',
  'hydropump': 'water',
  'hydrovortex': 'water',
  'hyperbeam': 'normal',
  'hyperfang': 'normal',
  'hypervoice': 'normal',
  'hyperspacefury': 'dark',
  'hyperspacehole': 'psychic',
  'hypnosis': 'psychic',
  'iceball': 'ice',
  'icebeam': 'ice',
  'iceburn': 'ice',
  'icefang': 'ice',
  'icehammer': 'ice',
  'icepunch': 'ice',
  'iceshard': 'ice',
  'iciclecrash': 'ice',
  'iciclespear': 'ice',
  'icywind': 'ice',
  'imprison': 'psychic',
  'incinerate': 'fire',
  'inferno': 'fire',
  'infernooverdrive': 'fire',
  'infestation': 'bug',
  'ingrain': 'grass',
  'instruct': 'psychic',
  'iondeluge': 'electric',
  'irondefense': 'steel',
  'ironhead': 'steel',
  'irontail': 'steel',
  'judgment': 'normal',
  'jumpkick': 'fighting',
  'karatechop': 'fighting',
  'kinesis': 'psychic',
  'kingsshield': 'steel',
  'knockoff': 'dark',
  'landswrath': 'ground',
  'laserfocus': 'normal',
  'lastresort': 'normal',
  'lavaplume': 'fire',
  'leafblade': 'grass',
  'leafstorm': 'grass',
  'leaftornado': 'grass',
  'leafage': 'grass',
  'leechlife': 'bug',
  'leechseed': 'grass',
  'leer': 'normal',
  'letssnuggleforever': 'fairy',
  'lick': 'ghost',
  'lightofruin': 'fairy',
  'lightscreen': 'psychic',
  'lightthatburnsthesky': 'psychic',
  'liquidation': 'water',
  'lockon': 'normal',
  'lovelykiss': 'normal',
  'lowkick': 'fighting',
  'lowsweep': 'fighting',
  'luckychant': 'normal',
  'lunardance': 'psychic',
  'lunge': 'bug',
  'lusterpurge': 'psychic',
  'machpunch': 'fighting',
  'magiccoat': 'psychic',
  'magicroom': 'psychic',
  'magicalleaf': 'grass',
  'magmastorm': 'fire',
  'magnetbomb': 'steel',
  'magnetrise': 'electric',
  'magneticflux': 'electric',
  'magnitude': 'ground',
  'maliciousmoonsault': 'dark',
  'matblock': 'fighting',
  'mefirst': 'normal',
  'meanlook': 'normal',
  'meditate': 'psychic',
  'megadrain': 'grass',
  'megakick': 'normal',
  'megapunch': 'normal',
  'megahorn': 'bug',
  'memento': 'dark',
  'menacingmoonrazemaelstrom': 'ghost',
  'metalburst': 'steel',
  'metalclaw': 'steel',
  'metalsound': 'steel',
  'meteormash': 'steel',
  'metronome': 'normal',
  'milkdrink': 'normal',
  'mimic': 'normal',
  'mindblown': 'fire',
  'mindreader': 'normal',
  'minimize': 'normal',
  'miracleeye': 'psychic',
  'mirrorcoat': 'psychic',
  'mirrormove': 'flying',
  'mirrorshot': 'steel',
  'mist': 'ice',
  'mistball': 'psychic',
  'mistyterrain': 'fairy',
  'moonblast': 'fairy',
  'moongeistbeam': 'ghost',
  'moonlight': 'fairy',
  'morningsun': 'normal',
  'mudbomb': 'ground',
  'mudshot': 'ground',
  'mudsport': 'ground',
  'mudslap': 'ground',
  'muddywater': 'water',
  'multiattack': 'normal',
  'mysticalfire': 'fire',
  'nastyplot': 'dark',
  'naturalgift': 'normal',
  'naturepower': 'normal',
  'naturesmadness': 'fairy',
  'needlearm': 'grass',
  'neverendingnightmare': 'ghost',
  'nightdaze': 'dark',
  'nightshade': 'ghost',
  'nightslash': 'dark',
  'nightmare': 'ghost',
  'nobleroar': 'normal',
  'nuzzle': 'electric',
  'oblivionwing': 'flying',
  'oceanicoperetta': 'water',
  'octazooka': 'water',
  'odorsleuth': 'normal',
  'ominouswind': 'ghost',
  'originpulse': 'water',
  'outrage': 'dragon',
  'overheat': 'fire',
  'painsplit': 'normal',
  'paraboliccharge': 'electric',
  'partingshot': 'dark',
  'payday': 'normal',
  'payback': 'dark',
  'peck': 'flying',
  'perishsong': 'normal',
  'petalblizzard': 'grass',
  'petaldance': 'grass',
  'phantomforce': 'ghost',
  'photongeyser': 'psychic',
  'pikapapow': 'electric',
  'pinmissile': 'bug',
  'plasmafists': 'electric',
  'playnice': 'normal',
  'playrough': 'fairy',
  'pluck': 'flying',
  'poisonfang': 'poison',
  'poisongas': 'poison',
  'poisonjab': 'poison',
  'poisonpowder': 'poison',
  'poisonsting': 'poison',
  'poisontail': 'poison',
  'pollenpuff': 'bug',
  'pound': 'normal',
  'powder': 'bug',
  'powdersnow': 'ice',
  'powergem': 'rock',
  'powersplit': 'psychic',
  'powerswap': 'psychic',
  'powertrick': 'psychic',
  'powertrip': 'dark',
  'powerwhip': 'grass',
  'poweruppunch': 'fighting',
  'precipiceblades': 'ground',
  'present': 'normal',
  'prismaticlaser': 'psychic',
  'protect': 'normal',
  'psybeam': 'psychic',
  'psychup': 'normal',
  'psychic': 'psychic',
  'psychicfangs': 'psychic',
  'psychicterrain': 'psychic',
  'psychoboost': 'psychic',
  'psychocut': 'psychic',
  'psychoshift': 'psychic',
  'psyshock': 'psychic',
  'psystrike': 'psychic',
  'psywave': 'psychic',
  'pulverizingpancake': 'normal',
  'punishment': 'dark',
  'purify': 'poison',
  'pursuit': 'dark',
  'quash': 'dark',
  'quickattack': 'normal',
  'quickguard': 'fighting',
  'quiverdance': 'bug',
  'rage': 'normal',
  'ragepowder': 'bug',
  'raindance': 'water',
  'rapidspin': 'normal',
  'razorleaf': 'grass',
  'razorshell': 'water',
  'razorwind': 'normal',
  'recover': 'normal',
  'recycle': 'normal',
  'reflect': 'psychic',
  'reflecttype': 'normal',
  'refresh': 'normal',
  'relicsong': 'normal',
  'rest': 'psychic',
  'retaliate': 'normal',
  'return': 'normal',
  'revelationdance': 'normal',
  'revenge': 'fighting',
  'reversal': 'fighting',
  'roar': 'normal',
  'roaroftime': 'dragon',
  'rockblast': 'rock',
  'rockclimb': 'normal',
  'rockpolish': 'rock',
  'rockslide': 'rock',
  'rocksmash': 'fighting',
  'rockthrow': 'rock',
  'rocktomb': 'rock',
  'rockwrecker': 'rock',
  'roleplay': 'psychic',
  'rollingkick': 'fighting',
  'rollout': 'rock',
  'roost': 'flying',
  'rototiller': 'ground',
  'round': 'normal',
  'sacredfire': 'fire',
  'sacredsword': 'fighting',
  'safeguard': 'normal',
  'sandattack': 'ground',
  'sandtomb': 'ground',
  'sandstorm': 'rock',
  'sappyseed': 'grass',
  'savagespinout': 'bug',
  'scald': 'water',
  'scaryface': 'normal',
  'scratch': 'normal',
  'screech': 'normal',
  'searingshot': 'fire',
  'searingsunrazesmash': 'steel',
  'secretpower': 'normal',
  'secretsword': 'fighting',
  'seedbomb': 'grass',
  'seedflare': 'grass',
  'seismictoss': 'fighting',
  'selfdestruct': 'normal',
  'shadowball': 'ghost',
  'shadowbone': 'ghost',
  'shadowclaw': 'ghost',
  'shadowforce': 'ghost',
  'shadowpunch': 'ghost',
  'shadowsneak': 'ghost',
  'sharpen': 'normal',
  'shatteredpsyche': 'psychic',
  'sheercold': 'ice',
  'shellsmash': 'normal',
  'shelltrap': 'fire',
  'shiftgear': 'steel',
  'shockwave': 'electric',
  'shoreup': 'ground',
  'signalbeam': 'bug',
  'silverwind': 'bug',
  'simplebeam': 'normal',
  'sing': 'normal',
  'sinisterarrowraid': 'ghost',
  'sizzlyslide': 'fire',
  'sketch': 'normal',
  'skillswap': 'psychic',
  'skullbash': 'normal',
  'skyattack': 'flying',
  'skydrop': 'flying',
  'skyuppercut': 'fighting',
  'slackoff': 'normal',
  'slam': 'normal',
  'slash': 'normal',
  'sleeppowder': 'grass',
  'sleeptalk': 'normal',
  'sludge': 'poison',
  'sludgebomb': 'poison',
  'sludgewave': 'poison',
  'smackdown': 'rock',
  'smartstrike': 'steel',
  'smellingsalts': 'normal',
  'smog': 'poison',
  'smokescreen': 'normal',
  'snarl': 'dark',
  'snatch': 'dark',
  'snore': 'normal',
  'soak': 'water',
  'softboiled': 'normal',
  'solarbeam': 'grass',
  'solarblade': 'grass',
  'sonicboom': 'normal',
  'soulstealing7starstrike': 'ghost',
  'spacialrend': 'dragon',
  'spark': 'electric',
  'sparklingaria': 'water',
  'sparklyswirl': 'fairy',
  'spectralthief': 'ghost',
  'speedswap': 'psychic',
  'spiderweb': 'bug',
  'spikecannon': 'normal',
  'spikes': 'ground',
  'spikyshield': 'grass',
  'spiritshackle': 'ghost',
  'spitup': 'normal',
  'spite': 'ghost',
  'splash': 'normal',
  'splinteredstormshards': 'rock',
  'splishysplash': 'water',
  'spore': 'grass',
  'spotlight': 'normal',
  'stealthrock': 'rock',
  'steameruption': 'water',
  'steamroller': 'bug',
  'steelwing': 'steel',
  'stickyweb': 'bug',
  'stockpile': 'normal',
  'stokedsparksurfer': 'electric',
  'stomp': 'normal',
  'stompingtantrum': 'ground',
  'stoneedge': 'rock',
  'storedpower': 'psychic',
  'stormthrow': 'fighting',
  'strength': 'normal',
  'strengthsap': 'grass',
  'stringshot': 'bug',
  'struggle': 'normal',
  'strugglebug': 'bug',
  'stunspore': 'grass',
  'submission': 'fighting',
  'substitute': 'normal',
  'subzeroslammer': 'ice',
  'suckerpunch': 'dark',
  'sunnyday': 'fire',
  'sunsteelstrike': 'steel',
  'superfang': 'normal',
  'superpower': 'fighting',
  'supersonic': 'normal',
  'supersonicskystrike': 'flying',
  'surf': 'water',
  'swagger': 'normal',
  'swallow': 'normal',
  'sweetkiss': 'fairy',
  'sweetscent': 'normal',
  'swift': 'normal',
  'switcheroo': 'dark',
  'swordsdance': 'normal',
  'synchronoise': 'psychic',
  'synthesis': 'grass',
  'tackle': 'normal',
  'tailglow': 'bug',
  'tailslap': 'normal',
  'tailwhip': 'normal',
  'tailwind': 'flying',
  'takedown': 'normal',
  'taunt': 'dark',
  'tearfullook': 'normal',
  'technoblast': 'normal',
  'tectonicrage': 'ground',
  'teeterdance': 'normal',
  'telekinesis': 'psychic',
  'teleport': 'psychic',
  'thief': 'dark',
  'thousandarrows': 'ground',
  'thousandwaves': 'ground',
  'thrash': 'normal',
  'throatchop': 'dark',
  'thunder': 'electric',
  'thunderfang': 'electric',
  'thunderpunch': 'electric',
  'thundershock': 'electric',
  'thunderwave': 'electric',
  'thunderbolt': 'electric',
  'tickle': 'normal',
  'topsyturvy': 'dark',
  'torment': 'dark',
  'toxic': 'poison',
  'toxicspikes': 'poison',
  'toxicthread': 'poison',
  'transform': 'normal',
  'triattack': 'normal',
  'trick': 'psychic',
  'trickroom': 'psychic',
  'trickortreat': 'ghost',
  'triplekick': 'fighting',
  'tropkick': 'grass',
  'trumpcard': 'normal',
  'twineedle': 'bug',
  'twinkletackle': 'fairy',
  'twister': 'dragon',
  'uturn': 'bug',
  'uproar': 'normal',
  'vcreate': 'fire',
  'vacuumwave': 'fighting',
  'veeveevolley': 'normal',
  'venomdrench': 'poison',
  'venoshock': 'poison',
  'vicegrip': 'normal',
  'vinewhip': 'grass',
  'vitalthrow': 'fighting',
  'voltswitch': 'electric',
  'volttackle': 'electric',
  'wakeupslap': 'fighting',
  'watergun': 'water',
  'waterpledge': 'water',
  'waterpulse': 'water',
  'watershuriken': 'water',
  'watersport': 'water',
  'waterspout': 'water',
  'waterfall': 'water',
  'weatherball': 'normal',
  'whirlpool': 'water',
  'whirlwind': 'normal',
  'wideguard': 'rock',
  'wildcharge': 'electric',
  'willowisp': 'fire',
  'wingattack': 'flying',
  'wish': 'normal',
  'withdraw': 'water',
  'wonderroom': 'psychic',
  'woodhammer': 'grass',
  'workup': 'normal',
  'worryseed': 'grass',
  'wrap': 'normal',
  'wringout': 'normal',
  'xscissor': 'bug',
  'yawn': 'normal',
  'zapcannon': 'electric',
  'zenheadbutt': 'psychic',
  'zingzap': 'electric',
  'zippyzap': 'electric',
};
