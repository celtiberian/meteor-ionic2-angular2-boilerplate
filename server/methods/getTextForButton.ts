
Meteor.methods({
    getTextForButton: function(idButton: number) {
        let textButton;

        if (idButton == 1) {
            textButton = "You have pressed Button 1";
        } else if (idButton == 2) {
            textButton = "You have pressed Button 2";
        } else {
            textButton = "You have not pressed any button";
        }

        return textButton;
    }
});