import 'dart:io';

mixin AbilityAttack {

    double attack1(damage) => damage*1.25;   
    double attack2(damage) => damage*1.50;   
    double attack3(damage) => damage*1.75;   
    double attack4(damage) => damage*2.00;   

}

mixin AbilityHeal {

    double heal1(restoration) => restoration * 1.25;
    double heal2(restoration) => restoration * 1.50;

}

mixin Control {

    double attackAbilityControl(character, character2){
        print("\x1B[2J\x1B[0;0H");

        print(character.getFightngStatus() + character2.getFightngStatus());
        print('\n[*] Select Attack Abiliy\n   1 - Slash \x1B[32mDamage(${character.getAttackAbility(1, true)}) Mana(${character.getSkillManaUsageInfo(1)})\x1B[37m\n   2 - Heavy \x1B[32mDamage(${character.getAttackAbility(2, true)}) Mana(${character.getSkillManaUsageInfo(2)})\x1B[37m\n   3 - Dragon Slayer \x1B[32mDamage(${character.getAttackAbility(3, true)}) Mana(${character.getSkillManaUsageInfo(3)})\x1B[37m\n   4 - OverPower \x1B[32mDamage(${character.getAttackAbility(4, true)}) Mana(${character.getSkillManaUsageInfo(4)})\x1B[37m\n   5 - Normal \x1B[32mDamage(${character.getAttackAbility(5, true)})\x1B[37m\n   \x1B[93mNothings - Back\x1B[0m');
        var selection = stdin.readLineSync();
        
        if(selection == '1' || selection == '2' || selection == '3' || selection == '4' || selection == '5'){
            return character.getAttackAbility(int.parse(selection!), false);
        }
        return -1;
    }

    double healAbilityControl(character, character2){
        print("\x1B[2J\x1B[0;0H");

        print(character.getFightngStatus() + character2.getFightngStatus());
        print('\n[*] Select Heal Abiliy\n   1 - Sintra \x1B[32mHeal(${character.getRestorationAbility(1, true)}) Mana(${character.getHealManaUsageInfo(1)})\x1B[37m\n   2 - Bioas \x1B[32mHeal(${character.getRestorationAbility(2, true)}) Mana(${character.getHealManaUsageInfo(2)})\x1B[37m\n   3 - Normal \x1B[32mHeal(${character.getRestorationAbility(3, true)}) Mana(${character.getHealManaUsageInfo(3)})\x1B[37m\n   \x1B[93mNothings - Back\x1B[0m');
        var selection = stdin.readLineSync();
        
        if(selection == '1' || selection == '2' || selection == '3' ){
            return character.getRestorationAbility(int.parse(selection!), false);
        }
        return -1;
    }
    
}
