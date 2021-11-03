import 'Arena.dart';
import 'Control.dart';
import 'Information.dart';

abstract class Character {

    double getAttackAbility(whichAbility, isInfo); /** Using character ability */
    void attack(character, ability); /** Attacking another character */

    double getRestorationAbility(whichAbility, isInfo); /** Using character ability */
    void heal(ability); /** Healing self when want to regen HP */

    void addExp(enemy); /** For added exp when finished fight */
    void levelUp(); /** Level up when win in the areana */
    
    void restoreStatus(); /** For restore status character */
    void getAttacked(damage); /** Get damage from another fighter */

    String getSkillManaUsageInfo(whichAbility);  /** For get mana skill using info */
    String getHealManaUsageInfo(whichAbility);  /** For get mana heal using info */
    String getHealthBar(); /** For get health bars */
    String getManaBar(); /** For get health bars */

    String getStatus(isPic); /** For show information of character */
    String getFightngStatus(); /** For show fighting information */
    String getCharacterPicture(); /** Get character picture */
    String getName(); /** For get the fighter name */
}

mixin DevelopTools {

    void debug(value){
        // print('[ DEBUG ]\n   $value');        
    }

}



class Fighter extends Character with AbilityAttack, AbilityHeal, Information, /* DevTools (debug)*/ DevelopTools {

    String 
    name = '',
    characterPic = "";

    int
    level = 1;
    
    double
    maxhp = 0.00, 
    hp = 0.00, 
    restoration = 0.00, 
    damage = 0.00,
    currentExp = 0.00,
    expGet = 0.00,
    baseMana = 0.00,
    mana = 0.00;
    
    Map<int, double> mappingSkillUsageMana = {
        1: 0.00,
        2: 0.00,
        3: 0.00,
        4: 0.00,
        5: 0.00
    };

    Map<int, double> mappingHealUsageMana = {
        1: 0.00,
        2: 0.00,
        3: 0.00
    };

    Fighter(name, level, hp, restoration, damage, characterPic, expGet, baseMana){
        this.level = level;
        this.characterPic = '\n'+characterPic;
        this.name = name;
        this.maxhp = hp;
        this.hp = hp;
        this.restoration = restoration;
        this.damage = damage;
        this.expGet = expGet;
        this.baseMana = baseMana;
        this.mana = baseMana;
        this.refreshManaUsage();
    }

    void refreshManaUsage(){
        mappingSkillUsageMana[1] = this.baseMana/4;
        mappingSkillUsageMana[2] = this.baseMana/3;
        mappingSkillUsageMana[3] = this.baseMana/2;
        mappingSkillUsageMana[4] = this.baseMana/1.5;

        mappingHealUsageMana[1] = this.baseMana/3;
        mappingHealUsageMana[2] = this.baseMana/2;

        mappingSkillUsageMana[5] = 0.00;
    }

    void attack(character, amount) {
        character.getAttacked(amount);
        debug("Attack ${character.getName()} @ DAMAGE( ${amount} )");
    }

    void heal(amount) {
        this.hp = this.hp + amount > this.maxhp ? this.maxhp : this.hp + amount;
        debug("Healed @ HP( ${this.hp}% )");
    }
    
    void restoreStatus(){
        this.hp = this.maxhp;
        this.mana = this.baseMana;
    }
    
    void addExp(enemy){

        var expAmount = enemy.level < this.level ? (enemy.expGet*0.5) : enemy.expGet*0.7; 

        this.currentExp += expAmount;
        String winInformation = '\n${callInformation('')}\n   🛡️  \x1B[92mWIN fight with ${enemy.getName()}\x1B[0m';

        if (this.currentExp > 99.99){
            this.currentExp -= 100.00; /** If exp more than 100% - 100 we gonna get the real exp gain in new vaule */
            this.levelUp();
            winInformation += '\n   💪🔥  Level UP ${this.level} - current EXP ${this.currentExp}';
        }else{
            winInformation += '\n   🔥  Exp gain ${expAmount}';
        }
        winInformation += '\n   ${this.getCharacterPicture()}\n${getWinPicture()}';

        flushScreen();

        print(winInformation);
    }

    void levelUp(){
        this.level++;
        this.maxhp *= 1.2;
        this.restoration *= 1.15;
        this.damage *= 1.15;
        this.baseMana *= 1.15;
        this.refreshManaUsage();
    }

    void getAttacked(damage){
        this.hp = this.hp - damage < 1 ? 0 : this.hp - damage;
        debug("[${this.name}] Get attack @DAMAGE( ${damage} ) @HP( ${this.hp}% )");
    }

    double getAttackAbility(whichAbility, isInfo) {

        if(isInfo){

            return whichAbility == 1 ? attack1(this.damage) :
            whichAbility == 2 ? attack2(this.damage) :
            whichAbility == 3 ? attack3(this.damage) :
            whichAbility == 4 ? attack4(this.damage) :
            this.damage;
            
        }

        if(mappingSkillUsageMana[whichAbility]! <= this.mana+0.01 && !isInfo){
            
            this.mana -= mappingSkillUsageMana[whichAbility]!;
            debug("Set attack [${this.name}] @ TO( ${whichAbility} ) DAMAGE_SKILL( +${whichAbility} )");

            return whichAbility == 1 ? attack1(this.damage) :
            whichAbility == 2 ? attack2(this.damage) :
            whichAbility == 3 ? attack3(this.damage) :
            whichAbility == 4 ? attack4(this.damage) :
            this.damage;

        }

        debug("Mana not enough! for SKILL");
        return -2;
    }

    double getRestorationAbility(whichAbility, isInfo) {

        if(isInfo) {
            return whichAbility == 1 ? heal1(this.restoration) :
            whichAbility == 2 ? heal2(this.restoration) :
            this.restoration;
        }

        if(mappingHealUsageMana[whichAbility]! <= this.mana+0.01 && !isInfo){
            this.mana -= mappingHealUsageMana[whichAbility]!;

            debug("Set heal [${this.name}] @ TO( ${whichAbility} ) RESTORATION_SKILL( +${whichAbility} )");

            return whichAbility == 1 ? heal1(this.restoration) :
            whichAbility == 2 ? heal2(this.restoration) :
            this.restoration;
        }

        debug("Mana not enough! for HEAL");
        return -2;
    }
    
    String getSkillManaUsageInfo(whichAbility) {
        return this.mappingSkillUsageMana[whichAbility]!.toStringAsFixed(2);
    }

    String getHealManaUsageInfo(whichAbility) {
        return this.mappingHealUsageMana[whichAbility]!.toStringAsFixed(2);
    }

    String getHealthBar(){
        if (this.hp > this.maxhp) return 'this player health obvious!';
        
        var currentPercent = this.hp * 100 / this.maxhp;
        var bar = '\x1B[0m';

        var percentColor =  currentPercent < 20 ? '\x1B[91m ' : currentPercent < 50 ? '\x1B[93m ' : '\x1B[92m';
        var colorSelector = currentPercent < 20 ? '\x1B[101m ' : currentPercent < 50 ? '\x1B[43m ' : '\x1B[102m ';

        for(var per = 0; per < currentPercent/10; per++){
            bar+=colorSelector;
        }

        return bar += '\x1B[0m ${percentColor}${currentPercent.toStringAsFixed(2)}%  \x1B[0m(${this.hp.toStringAsFixed(2)})';
    }

    String getManaBar(){
        if (this.mana > this.baseMana) return 'this player mana obvious!';
        
        var currentPercent = this.mana * 100 / this.baseMana;
        var bar = '\x1B[0m';
        
        for(var per = 0; per < currentPercent/10; per++){
            bar+='\x1B[44m ';
        }

        return bar += '\x1B[0m \x1B[94m${currentPercent.toStringAsFixed(2)}%  \x1B[0m(${this.mana.toStringAsFixed(2)})';
    }

    String getStatus(isPic){
        var strInfo = '';
        if(isPic){
            strInfo+='\n${this.characterPic}';
        }
        strInfo+='\n   @ ( \x1B[96m${this.name}\x1B[0m )\n|   \x1B[32mLevel\x1B[0m: ${this.level}\n|   \x1B[33mEXP\x1B[0m: ${this.currentExp.toStringAsFixed(2)}\n|   \x1B[91mHP\x1B[0m: ${this.hp.toStringAsFixed(2)}\n|   \x1B[92mBase Restoration\x1B[0m: ${this.restoration.toStringAsFixed(2)}\n|   \x1B[35mBase Damage\x1B[0m: ${this.damage.toStringAsFixed(2)}\n|   \x1B[35mMana\x1B[0m: ${this.mana.toStringAsFixed(2)}';
        
        return strInfo;
    }

    String getCharacterPicture(){
        return this.characterPic;
    }

    String getName(){
        return this.name;
    }

    String getFightngStatus(){
        return '\n${this.characterPic}\n   @ ( \x1B[96m${this.name}\x1B[0m )\n|   \x1B[32mLevel\x1B[0m: ${this.level}\n|   \x1B[91mHP\x1B[0m: ${this.getHealthBar()}\n|   \x1B[35mMana\x1B[0m: ${this.getManaBar()}';
    }

}