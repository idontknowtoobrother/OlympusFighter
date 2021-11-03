import 'dart:math';


// Bot Intelligent
mixin BotIntelligent {

    bool isBotHaveEnoughMana(enemy, ability, type){
        if(type == 'heal'){
            return enemy.mana > enemy.mappingHealUsageMana[ability];
        }else if(type == 'atk'){
            return enemy.mana > enemy.mappingSkillUsageMana[ability];
        }
        return false;
    }

    String botProcessControl(enemy, player){

        if(enemy.hp < 00.01){
            return '\n   ${enemy.getName()}\t💀  Died';
        }else if(enemy.hp > (enemy.hp * 50 / 100)){

            /** If enemy health > 50% enemy will focus on 'Attack' more than 'Heal' */

            if (Random().nextInt(3) > 0){

                var randAtk  = Random().nextInt(5)+1; // 1 - 4 Ability Attack or Normal

                if(isBotHaveEnoughMana(enemy, randAtk, 'atk')){
                    enemy.attack(player, enemy.getAttackAbility(randAtk, false));
                    return '\n   ${enemy.getName()}\t🗡️  ${enemy.getAttackAbility(randAtk, true)}';
                }

                // Default case of healing when not enough mana :D
                enemy.attack(player, enemy.getAttackAbility(5, false));
                return '\n   ${enemy.getName()}\t🗡️  Base Damage ${enemy.getAttackAbility(5, true)}';
                
            }else{

                if(enemy.hp < enemy.maxhp){

                    var randHeal  = Random().nextInt(3)+1; // 1 - 2 Heal Attack or Normal

                    if(isBotHaveEnoughMana(enemy, randHeal, 'heal')){
                        enemy.heal(enemy.getRestorationAbility(randHeal, false));
                        return '\n   ${enemy.getName()}\t💚 ${enemy.getRestorationAbility(randHeal, true)}';
                    }

                    // Default case of healing when not enough mana :D
                    enemy.heal(enemy.getRestorationAbility(3, false));
                    return '\n   ${enemy.getName()}\t💚 Base Heal ${enemy.getRestorationAbility(3, true)}';

                }else{
                    
                    var randAtk  = Random().nextInt(5)+1;

                    if(isBotHaveEnoughMana(enemy, randAtk, 'atk')){

                        enemy.attack(player, enemy.getAttackAbility(randAtk, false));
                        return '\n   ${enemy.getName()}\t🗡️  ${enemy.getAttackAbility(randAtk, true)}';

                    }

                    // Default case of healing when not enough mana :D
                    enemy.attack(player, enemy.getAttackAbility(5, false));
                    return '\n   ${enemy.getName()}\t🗡️  Base Damage ${enemy.getAttackAbility(5, true)}';

                }
            }

        }else{ 

            /** If enemy health < 50% enemy will focus on 'Heal' more than 'Attack' */

            if (Random().nextInt(3) > 0 && enemy.hp < enemy.maxhp){

                var randHeal  = Random().nextInt(3)+1; 

                if(isBotHaveEnoughMana(enemy, randHeal, 'heal')){
                    enemy.heal(enemy.getRestorationAbility(randHeal, false));
                    return '\n   ${enemy.getName()}\t💚 ${enemy.getRestorationAbility(randHeal, true)}';
                }

                // Default case of healing when not enough mana :D
                enemy.heal(enemy.getRestorationAbility(3, false));
                return '\n   ${enemy.getName()}\t💚 Base Heal ${enemy.getRestorationAbility(3, true)}';
                
            }else{

                var randAtk  = Random().nextInt(5)+1;

                if(isBotHaveEnoughMana(enemy, randAtk, 'atk')){
                    enemy.attack(player, enemy.getAttackAbility(randAtk, false));
                    return '\n   ${enemy.getName()}\t🗡️  Base Damage ${enemy.getAttackAbility(randAtk, true)}';
                }

                // Default case of healing when not enough mana :D
                enemy.attack(player, enemy.getAttackAbility(5, false));
                return '\n   ${enemy.getName()}\t🗡️  Base Damage ${enemy.getAttackAbility(5, true)}';

            }

        }

    }

}