import 'dart:io';
import 'Fighter.dart';
import 'Control.dart';
import 'Intelligent.dart';
import 'Information.dart';

abstract class Arena {
    
    void startFightProcess(characterRed, characteBlue, information); /** Assert two fighter into Arena */
    void repeatRound(characterRed, characteBlue); /** Repeat round when not get the winner */
    void requestFighterDecide(characterRed, characteBlue); /** Asking fighter for what wanna do after done */
    void refreshEnemyDiff(characterLevel);

    String spanFigtherInfo(characterRed, characteBlue); /** ใช่เพื่อถึงข้อมูลโชว์สถานะของสองผู้เล่น */
    int winableCheck(characterRed, characteBlue); /** When fight end and winner become here */
    
}

class OlympusArena extends Arena with Control, BotIntelligent, Information {

    /** Fighter */
    static var fighterList = [
        Fighter('Gladiator', 1, 300.00, 15.00, 19.99, '''
                            ▒▒▒▒
                            ▒▒▒▒
                          ▒▒▓▓▓▓▒▒
                      ▓▓██▒▒▓▓▓▓▒▒▓▓
                  ▒▒▒▒▓▓▒▒▓▓▒▒▒▒▒▒▒▒▓▓
                  ▓▓▒▒██▓▓██▓▓▒▒▒▒██▒▒▒▒
                  ██▓▓▒▒██▓▓▓▓▓▓▓▓▓▓██▒▒
                ▓▓▓▓▓▓░░░░▓▓▓▓▓▓▓▓▓▓▓▓████▒▒
              ▓▓▓▓██░░░░░░▒▒▓▓▒▒▒▒░░▒▒████
              ▒▒▓▓██░░░░▒▒▒▒▓▓▒▒▒▒▒▒▒▒████
                ▓▓▓▓░░░░▒▒▒▒▓▓▓▓▓▓▒▒░░██▓▓
                  ▓▓░░░░▒▒▓▓██▓▓▓▓▓▓░░▓▓▒▒
                  ▒▒▓▓▒▒▓▓▓▓██▓▓▓▓██▓▓▒▒
                    ▒▒▒▒▓▓▓▓██▓▓▓▓▓▓▓▓▒▒
                      ▓▓▓▓▓▓██▓▓▓▓▓▓▓▓
                      ▓▓▓▓▓▓██████▓▓▓▓
                      ▓▓▒▒▒▒██▓▓██▓▓▒▒
                      ▓▓▒▒░░▒▒░░▒▒▒▒
                      ▓▓▒▒      ██
                      ▒▒        ▒▒
                      ▒▒        ██▓▓
                    ▓▓██
        ''', 50.0, 100.00),
        Fighter('Alexios', 2, 600.00, 30.00, 65.00, '''
                     ▒▒
                   ▒▒▓▓
                 ▓▓▒▒▓▓▒▒▒▒
               ▒▒▒▒▒▒▓▓▓▓  
                 ▒▒▒▒██▓▓▒▒
               ▒▒░░░░░░▓▓▓▓
                 ▒▒▒▒▓▓░░▒▒  
               ██▓▓▓▓▓▓▓▓██
               ▓▓▒▒▒▒▓▓████
               ▓▓▓▓▒▒▓▓████▒▒
               ▒▒▓▓▓▓▓▓██▒▒
                 ▓▓▒▒▒▒██▒▒
                 ▓▓██░░▓▓▒▒
                   ██    ▒▒
                   ██    ██
                   ██    ▓▓
                   ██    ▒▒▒▒
        ''',70.0, 600.00),
        Fighter('Demios', 3, 1200.00, 80.00, 120.00, '''
                      ▓▓▒▒
                    ▒▒▓▓▒▒
                    ▒▒▓▓
                  ▒▒▒▒▓▓
                ▒▒▒▒▒▒▓▓▓▓▒▒▒▒
                ▒▒▒▒▒▒▒▒▓▓▓▓▒▒
              ▓▓▒▒▓▓▓▓▒▒▓▓▓▓▓▓
            ▒▒██▓▓▓▓▒▒▒▒▒▒▓▓▓▓██
            ▒▒▓▓▓▓▓▓▒▒▒▒▒▒▓▓▒▒██
            ▒▒▒▒▓▓▓▓▓▓░░▒▒██▒▒░░▓▓
            ▒▒▒▒▓▓▓▓▒▒░░▓▓▓▓▓▓░░██
              ▒▒▓▓▓▓▒▒▒▒▓▓▓▓▓▓░░▓▓
              ▓▓██▓▓▒▒▓▓▓▓▓▓▓▓▒▒
              ▓▓▓▓▓▓▓▓██▓▓▓▓▓▓▓▓
              ▓▓▓▓▓▓▓▓██▓▓▓▓██▓▓
              ▓▓▓▓▓▓██▓▓▓▓▓▓████
              ▓▓▓▓▓▓██▓▓▓▓▓▓██▓▓
              ▓▓▓▓▓▓▓▓▓▓▓▓██▓▓▓▓
              ▓▓██▓▓        ██▓▓
              ▒▒▓▓▒▒        ██
              ░░▓▓          ██
              ▒▒▓▓          ▒▒▓▓▒▒
              ██▒▒
        ''', 80.0, 800.00),
        Fighter('Leonidas', 10, 3000.00, 200.00, 250.00, '''
            ▓▓▓▓▒▒▒▒▒▒                            ▒▒░░░░▓▓▒▒░░▒▒▒▒▓▓
                ▒▒▒▒▒▒▒▒▓▓████▒▒░░░░░░░         ▒▒▒▒▒▒
                    ▒▒▒▒▒▒▓▓██▓▓░░    ░░░░    ▒▒▓▓▓▓▓▓▒▒▒▒
            ▓▓▓▓▓▓▓▓▒▒▒▒░░▒▒██▓▓░░  ░░░░░░    ▓▓▓▓▓▓░░░░▒▒▒▒▓▓▓▓▓▓▓▓▒▒
            ▒▒▒▒░░░░░░▓▓▓▓▓▓██▓▓▒▒░░  ░░░░░   ▒▒▓▓▒▒▒▒▓▓▒▒        ▒▒
                  ▓▓▓▓▒▒░░▓▓▓▓██▓▓░░░░░░░░░░▒▒▓▓▒▒▓▓▒▒░░▒▒▓▓▓▓
            ▒▒▓▓▓▓▒▒░░▒▒▓▓▒▒▒▒▓▓▓▓░░▒▒  ▒▒▒▒▓▓▒▒▓▓░░▓▓▒▒    ▒▒▓▓▒▒▒▒
                    ▓▓▓▓  ░░▓▓░░░░      ▒▒░░▓▓▓▓▒▒▓▓░░▒▒▓▓▒▒
                  ▓▓▒▒░░░░▓▓░░▒▒▓▓░░  ▓▓▒▒▒▒░░▓▓░░▓▓▒▒░░▒▒▒▒▓▓
                ▓▓▓▓░░░░▒▒▒▒▒▒▓▓░░▒▒░░░░▒▒▒▒██▓▓▒▒░░▓▓      ▒▒▓▓
                      ▓▓▓▓▒▒▒▒▓▓░░████░░▒▒▓▓▒▒▓▓▒▒░░▒▒▓▓
                    ▒▒▓▓▒▒▓▓▓▓▒▒░░▓▓▒▒▓▓░░▓▓░░▒▒▓▓░░░░▓▓▒▒
                    ▓▓▓▓  ▒▒▓▓░░▓▓██▓▓██░░░░░░░░▒▒░░░░▒▒▓▓▒▒
                            ▓▓░░██▓▓▒▒▒▒░░░░░░░░▓▓▓▓
                                ▓▓▓▓██░░░░░░
                                ▒▒██▓▓░░░░
                                ▒▒▒▒    ▒▒
                                ▒▒▒▒    ▒▒
                                ▒▒▒▒    ▒▒
                                ▒▒▒▒    ▒▒
                                  ▒▒    ▒▒
                                  ▒▒    ▒▒
                                  ▒▒    ▒▒
                              ▒▒▓▓▒▒    ▒▒██
        ''', 90.0, 1000.00)
    ];


    void mainMenu(player){

        flushScreen();

        print('''[*] Welcome to Olympus Arena\x1B[91m
                                                    ▒▒▒▒▒▒▒▒▒▒
                                                  ▒▒        ▒▒
                                                ▒▒░░      ░░▒▒
                                              ▒▒  ░░    ░░░░▒▒
                                            ▒▒░░  ░░  ░░░░░░▒▒
                                            ▒▒    ░░░░░░░░▒▒  
                                          ▒▒░░    ░░░░░░▒▒    
                                        ▒▒░░    ░░░░░░▒▒      
                                      ▒▒░░    ░░░░▒▒▒▒        
                                      ▒▒░░  ░░░░▒▒            
                              ▒▒    ▒▒░░░░░░░░▒▒              
            ████            ▒▒  ▒▒▒▒░░  ░░▒▒▒▒                
          ██▒▒▒▒████    ▒▒  ▒▒  ░░░░  ░░▒▒                    
            ██▓▓▒▒▒▒██  ░░▒▒▒▒░░░░  ░░▒▒                      
              ██▓▓▒▒██  ▒▒▒▒░░░░  ░░░░▒▒                      
              ██▓▓▓▓▒▒████░░  ░░░░░░    ▒▒                    
            ██▒▒▓▓▓▓▓▓▒▒▒▒░░░░  ░░▒▒▒▒▒▒                      
          ██▒▒▓▓████▒▒▓▓░░░░░░░░▒▒▒▒                          
          ██▓▓██    ██▒▒░░░░▒▒██▒▒░░▒▒                        
            ██    ████▒▒▒▒▓▓▒▒██                              
                ██▒▒▓▓████▒▒▓▓▒▒████                          
              ██▓▓▓▓▒▒██  ██▓▓▓▓▒▒▒▒██                        
              ██▓▓▓▓██    ██▓▓▓▓▓▓▒▒██                        
            ██▓▓████    ██▓▓▒▒████▓▓▒▒██                      
          ██▓▓██      ██▓▓▒▒██    ██▒▒██                      
        ██▓▓██          ████        ██                        
        ████\x1B[0m\n\n   1. My Player Status\n   2. Choose Enemy ( Fight )\n   3. Exit''');

        var selection = stdin.readLineSync();
        
        if(selection == '1'){

            flushScreen();
            print(player.getStatus(true));
            stdin.readLineSync(); /** ใช้เพื่อ Pause การทำงานให้ player ได้ focus ข้อมูล*/
            return mainMenu(player);
        }else if(selection == '2'){

            
            return this.fighterInformation(player);
        }else if(selection == '3'){

            flushScreen();
            return print('Olympus Exited.');
        }else{

            
            warning("not found your selection");
            return mainMenu(player);
        }
    }


    void fighterInformation(player){

        flushScreen();
        String selectInfo = '\n[*] Select your enemy\n   ';
        int index = 1;
        for(Fighter indexFighter in fighterList){
            print(indexFighter.getStatus(false));
            selectInfo+='[${index}] ${indexFighter.getName()}\n   ';
            index++;
        }

        selectInfo+='[${index}] Back to Main Menu';

        print(selectInfo);

        /** ดัก error หากไม่ใส่ตัวเลข */
        int selection = -1;
        try {
           selection = int.parse(stdin.readLineSync()!);
        } on FormatException { 
            return this.fighterInformation(player);
        } 
        /**  ดัก error หากไม่ใส่ตัวเลข  */


        if(selection == index){

            return mainMenu(player);
        }else if(selection <= fighterList.length){

            return this.startFightProcess(player, fighterList[selection-1], '⚔️  Fight with ${fighterList[selection-1].getName()}');
        }else if(selection > fighterList.length){

            warning("fighter has only ${fighterList.length}");
            return this.fighterInformation(player);
        }
    }

    void repeatRound(player, enemy) {
        this.startFightProcess(player, enemy, "Restart with this fighter !");
    }

    void requestFighterDecide(player, enemy){

        player.restoreStatus();
        enemy.restoreStatus();

        print('\n[*] End this fight\n   1. Reload this fight\n   2. Back to Main Menu');
        var selection = stdin.readLineSync();
        if(selection == '1'){
            return this.repeatRound(player, enemy);
        }else if(selection == '2'){
            return this.mainMenu(player);
        }else{
            return this.requestFighterDecide(player, enemy);
        }

    }

    void startFightProcess(player, enemy, information) {

        flushScreen();
        detailFightingInfo(player, enemy);
        print('\n${callInformation('')}\n   ${information}\n\x1B[94m[ * ]\x1B[0m ${player.getName()} Turn\n    \x1B[91m1 - Attack\x1B[0m\n    \x1B[92m2 - Heal\x1B[0m');       

        var newInformation = '';
        
        /*
        *  Player Level Cached in Arena Fight
        */

        var playerLevelCached = player.level;

        var selection = stdin.readLineSync();
        if(selection == '1'){
            var attackAmount = attackAbilityControl(player, enemy);

            if(attackAmount == -2) return this.startFightProcess(player, enemy, '🧴 Mana not enough!');
            if(attackAmount == -1) return this.startFightProcess(player, enemy, '⚔️  Fight with ${enemy.getName()}'); /** If -1 it's gonna select new decide */

            player.attack(enemy, attackAmount);
            newInformation+= '${player.getName()}\t🗡️  ${attackAmount}\t${enemy.getName()}';
        }else if(selection == '2'){
            var healAmount = healAbilityControl(player, enemy);

            if(healAmount == -2) return this.startFightProcess(player, enemy, '🧴 Mana not enough!');
            if(healAmount == -1) return this.startFightProcess(player, enemy, '⚔️  Fight with ${enemy.getName()}'); /** If -1 it's gonna select new decide */

            player.heal(healAmount);
            newInformation+= '${player.getName()}\t💚 ${healAmount}';
        }else{

            
            return startFightProcess(player, enemy, "Not found ur selection !");
        }

        newInformation += botProcessControl(enemy, player);
        
        var caseResult = winableCheck(player, enemy);
        
        if( caseResult == 3 ){
            
            return startFightProcess(player, enemy, newInformation);
        }else if( caseResult == 2){
            
            flushScreen();
            print('\n${callInformation('\n   ${newInformation}')}\n   ${spanFigtherInfo(player, enemy)}\n   👎  \x1B[96mLOSE fight to ${enemy.getName()}\x1B[0m\n   ${enemy.getCharacterPicture()}\n${getWinPicture()}');
            return requestFighterDecide(player, enemy);
        }else if( caseResult == 1 ){
            print('\n${callInformation('\n   ${newInformation}')}\n   ${spanFigtherInfo(player, enemy)}');
            if(player.level > playerLevelCached){
                refreshEnemyDiff(player.level);
            }
            return requestFighterDecide(player, enemy);
        }
    }

    void refreshEnemyDiff(playerLevel){
        for(Fighter fighter in fighterList){
            if(fighter.level < playerLevel){
                fighter.levelUp();
            }
        }
    }

    String spanFigtherInfo(player, enemy){
        return '\n   @ ( \x1B[96m${player.name}\x1B[0m )\t\t\t@ ( \x1B[96m${enemy.name}\x1B[0m )\n|   \x1B[32mLevel\x1B[0m: ${player.level}\t\t\t   |   \x1B[32mLevel\x1B[0m: ${enemy.level}\t\t\t\n|   \x1B[33mEXP\x1B[0m: ${player.currentExp}\t\t\t   |   \x1B[33mEXP\x1B[0m: ${enemy.currentExp}\t\t\t\n|   \x1B[91mHP\x1B[0m: ${player.hp.toStringAsFixed(2)}\t\t\t   |   \x1B[91mHP\x1B[0m: ${enemy.hp.toStringAsFixed(2)}';
    }

    int winableCheck(player, enemy) {
        if(enemy.hp < 0.01 && player.hp > 0.01){
            player.addExp(enemy);
            return 1;
        }else if(player.hp < 0.01 && enemy.hp > 0.01){
            return 2;
        }else{
            return 3;
        }
    }

}