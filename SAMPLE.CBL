      *>--------------------------------------------------------------------------------------------------------------<*
      *>-> SAMPLE: MessageBox usages
      *>--------------------------------------------------------------------------------------------------------------<*
       identification             division.
       program-id.                sample.
       environment                division.
       configuration              section.
       special-names.
           decimal-point     is   comma,
           console           is   crt.
       repository.
           class MessageBox as "MSGBOX"
           .
       data                       division.
      *>--------------------------------------------------------------------------------------------------------------<*
       working-storage            section.
       77  msg                    object reference MessageBox.
       77  w-number               pic is 9(04)    value is zeros.
       77  w-text                 pic is x any length value is spaces.
      *>--------------------------------------------------------------------------------------------------------------<*
       procedure                  division.
       begin.

      *>-> Basic message using only a text
           MessageBox:>show("Basic message using static method").

      *>-> Changing icon
           MessageBox:>new("Error message using constructor and icon customization"):>withErrorIcon:>show.

      *>-> Multiple customizations such as title, icon and buttons
           set     msg       to   MessageBox:>new("Warning message, customizing title and buttons")
                                            :>withTitle("Customized message title")
                                            :>withWarningIcon
                                            :>buttonsYesNo
                                            :>defaultButtonNo
                                            :>show.
      *>-> Testing which button was selected
           if msg:>actionYes
              MessageBox:>show('Button "Yes" selected'),
           end-if.
           if msg:>actionNo
              MessageBox:>show('Button "No" selected'),
           end-if.

      *>-> Using place holders on message to display information from variables
           move    123       to   w-number.
           move    "ABC"     to   w-text.
           MessageBox:>new("Message using placeholders to display variables such a number (%1) and a text (%2)")
                     :>addSub(w-number)
                     :>addSub(w-text)
                     :>show.

      *>-> Invoking and testing the return in one line
           if MessageBox:>new("Do you want to continue?"):>buttonsYesNo:>show:>actionYes
              MessageBox:>show('Button "Yes" selected'),
           end-if.

           stop                   run.
      *>--------------------------------------------------------------------------------------------------------------<*
