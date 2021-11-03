mixin Information {

    void flushScreen(){
        print("\x1B[2J\x1B[0;0H");
    }

    void detailFightingInfo(player, enemy){
        print(player.getFightngStatus() + enemy.getFightngStatus());
    }

    String callInformation(text){
        return '\x1B[94m[ * Information ]\x1B[37m $text \x1B[0m';
    }

    String getWinPicture(){
        return '''\x1B[92m

            ██╗       ██╗██╗███╗  ██╗
            ██║  ██╗  ██║██║████╗ ██║
            ╚██╗████╗██╔╝██║██╔██╗██║
             ████╔═████║ ██║██║╚████║
             ╚██╔╝ ╚██╔╝ ██║██║ ╚███║
              ╚═╝   ╚═╝  ╚═╝╚═╝  ╚══╝

        \x1B[0m''';
    }

    void warning(text){
        return print("[ Warning ] ${text}"); 
    }

}
