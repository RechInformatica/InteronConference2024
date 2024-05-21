      *>--------------------------------------------------------------------------------------------------------------<*
      *>-> Message display using OO
      *>--------------------------------------------------------------------------------------------------------------<*
       class-id.                  msgbox.
       environment                division.
       configuration              section.
       special-names.
           decimal-point     is   comma.
      *>--------------------------------------------------------------------------------------------------------------<*
      *>-> Import another necessary classes
       repository.
           class ICobolVar as "com.iscobol.types.CobolVar"
           class JBoolean as "boolean"
           class MessageBox as "MSGBOX"
           .
      *>--------------------------------------------------------------------------------------------------------------<*
      *>-> STATIC AREA
      *>--------------------------------------------------------------------------------------------------------------<*
       id division. factory.
       working-storage            section.
      *>--------------------------------------------------------------------------------------------------------------<*
      *>-> Constants found on "isgui.def"
      *>--------------------------------------------------------------------------------------------------------------<*
      *>-> Buttons
       78  mb-ok                                  value 1.
       78  mb-yes-no                              value 2.
       78  mb-ok-cancel                           value 3.
       78  mb-yes-no-cancel                       value 4.
      *>-> Return code
       78  mb-yes                                 value 1.
       78  mb-no                                  value 2.
       78  mb-cancel                              value 3.
      *>-> Icons
       78  mb-default-icon                        value 1.
       78  mb-warning-icon                        value 2.
       78  mb-error-icon                          value 3.
       procedure                  division.
      *>--------------------------------------------------------------------------------------------------------------<*
      *>/**
      *> Displays a standard information message using provided text
      *>
      *> @param inText Text to display
      *>*/
       id division. method-id. show as "show".
       linkage                    section.
       77  inText                 object reference ICobolVar.
       procedure                  division using inText.
       show.
           MessageBox:>new(inText):>show.
       end method.
       end factory.
      *>--------------------------------------------------------------------------------------------------------------<*
      *>-> OBJECT AREA
      *>--------------------------------------------------------------------------------------------------------------<*
       id division. object.
       working-storage            section.
      *>-> Self reference to this object
       77  selfInstance           object reference MessageBox.
      *>-> Message text
       77  w-text                 pic x any length value is spaces.
      *>-> Message title
       77  w-title                pic x any length value is spaces.
      *>-> Icon
       77  w-icon                 pic is 9(01)    value is mb-default-icon comp-x.
           88 w-icon-default                      value is mb-default-icon.
           88 w-icon-warning                      value is mb-warning-icon.
           88 w-icon-error                        value is mb-error-icon.
      *>-> Buttons
       77  w-buttons              pic is 9(01)    value is mb-ok comp-x.
           88 w-buttons-ok                        value is mb-ok.
           88 w-buttons-yesno                     value is mb-yes-no.
           88 w-buttons-okcancel                  value is mb-ok-cancel.
           88 w-buttons-yesnocancel               value is mb-yes-no-cancel.
       77  w-default-button       pic is 9(01)    value is mb-yes comp-x.
           88 w-default-button-yes                value is mb-yes.
           88 w-default-button-no                 value is mb-no.
      *>-> Return
       77  w-return               pic is 9(01)    value is zeros comp-x.
           88 w-return-yes                        value is mb-yes.
           88 w-return-no                         value is mb-no.
           88 w-return-cancel                     value is mb-cancel.
      *>-> Text substitutions table
       01  w-subst-tab.
           05 w-subst-occ                        occurs dynamic
                                               capacity in w-subst-size initialized.
              10 w-subst          pic x any length value is spaces.
      *>--------------------------------------------------------------------------------------------------------------<*
       procedure                  division.
      *>--------------------------------------------------------------------------------------------------------------<*
      *>/**
      *> Object constructor
      *>
      *> @param inText Text to display
      *>*/
       id division. method-id. new_met as "new".
       linkage                    section.
       77  inText                 object reference ICobolVar.
       procedure                  division using inText.
           move    inText    to   w-text.
      *>-> Saves a referente to this own object, allowing return it on each method for "Builder Pattern"
           set     selfInstance to self.
       end method.
      *>--------------------------------------------------------------------------------------------------------------<*
      *>/**
      *> Adds a substition text element to be applied on message text
      *>
      *> @param inText Text to be replaced on message place holders
      *>*/
       id division. method-id. addSub as "addSub".
       linkage                    section.
       77  inText                 object reference ICobolVar.
       procedure                  division using inText returning selfInstance.
           move    function trim(inText) to w-subst(w-subst-size + 1).
       end method.
      *>--------------------------------------------------------------------------------------------------------------<*
      *>/**
      *> Defines a custom title
      *>
      *> @param inTitle Message title text
      *>*/
       id division. method-id. withTitle as "withTitle".
       linkage                    section.
       77  inTitle                object reference ICobolVar.
       procedure                  division using inTitle returning selfInstance.
           move    inTitle   to   w-title.
       end method.
      *>--------------------------------------------------------------------------------------------------------------<*
      *>/**
      *> Allows "Yes" and "No" buttons
      *> After "show", use methods "actionYes" or "actionNo" to test which button was pressed
      *>
      *>*/
       id division. method-id. buttonsYesNo as "buttonsYesNo".
       procedure                  division returning selfInstance.
           set     w-buttons-yesno to true.
       end method.
      *>--------------------------------------------------------------------------------------------------------------<*
      *>/**
      *> Allows "OK" and "Cancel" buttons
      *> After "show", use methods "actionOk" or "actionCancel" to test which button was pressed
      *>
      *>*/
       id division. method-id. buttonsOkCancel as "buttonsOkCancel".
       procedure                  division returning selfInstance.
           set     w-buttons-okcancel to true.
       end method.
      *>--------------------------------------------------------------------------------------------------------------<*
      *>/**
      *> Allows "Yes", "No" and "Cancel" buttons
      *> After "show", use methods "actionYes", "actionNo" or "actionCancel" to test which button was pressed
      *>
      *>*/
       id division. method-id. buttonsYesNoCancel as "buttonsYesNoCancel".
       procedure                  division returning selfInstance.
           set     w-buttons-okcancel to true.
       end method.
      *>--------------------------------------------------------------------------------------------------------------<*
      *>/**
      *> Makes button "No" focused by default
      *>
      *>*/
       id division. method-id. defaultButtonNo as "defaultButtonNo".
       procedure                  division returning selfInstance.
           set     w-default-button-no to true.
       end method.
      *>--------------------------------------------------------------------------------------------------------------<*
      *>/**
      *> Defines icon as "Error"
      *>
      *>*/
       id division. method-id. withErrorIcon as "withErrorIcon".
       procedure                  division returning selfInstance.
           set     w-icon-error   to true.
       end method.
      *>--------------------------------------------------------------------------------------------------------------<*
      *>/**
      *> Defines icon as "Warning"
      *>
      *>*/
       id division. method-id. withWarningIcon as "withWarningIcon".
       procedure                  division returning selfInstance.
           set     w-icon-warning to true.
       end method.
      *>--------------------------------------------------------------------------------------------------------------<*
      *>/**
      *> Display message
      *>
      *>*/
       id division. method-id. show as "show".
       working-storage            section.
       77  table-i                pic is 9(04)    value is zeros comp-x.
       77  mask-i                 pic is zzzz9    value is zeros.
       77  place-holder           pic x any length value is spaces.
       procedure                  division returning selfInstance.
           if w-title = spaces
              perform             load-default-title,
           end-if.
           if w-subst-size > 0
              perform             apply-substitutions-on-text,
           end-if.
           display                message w-text
                                  title w-title
                                  type w-buttons
                                  default w-default-button
                                  icon w-icon
                                  centered
                                  returning w-return.
           exit                   method.
       load-default-title.
           evaluate               true,
              when w-icon-default
                 if w-buttons-yesno or w-buttons-yesnocancel
                    move "Question message" to w-title,
                 else,
                    move "Information" to w-title,
                 end-if,
              when w-icon-warning
                 move "Warning message" to w-title,
              when w-icon-error
                 move "Error message" to w-title,
           end-evaluate.
       apply-substitutions-on-text.
           perform
              varying             table-i from w-subst-size by -1
                 until            table-i = 0
              move spaces    to   place-holder,
              move table-i   to   mask-i,
              string              "%", function trim(mask-i)
                 into             place-holder,
              call "C$REPLACE_ALL" using w-text, place-holder, w-subst(table-i),
           end-perform.
       end method.
      *>--------------------------------------------------------------------------------------------------------------<*
      *>/**
      *> Return true if button "Yes" was selected
      *>
      *> @return boolean
      *>*/
       id division. method-id. actionYes as "actionYes".
       working-storage            section.
       77  outReturn              object reference JBoolean.
       procedure                  division returning outReturn.
           if w-return-yes
              set  outReturn to   true,
           else,
              set  outReturn to   false,
           end-if.
       end method.
      *>--------------------------------------------------------------------------------------------------------------<*
      *>/**
      *> Return true if button "No" was selected
      *>
      *> @return boolean
      *>*/
       id division. method-id. actionNo as "actionNo".
       working-storage            section.
       77  outReturn              object reference JBoolean.
       procedure                  division returning outReturn.
           if w-return-no
              set  outReturn to   true,
           else,
              set  outReturn to   false,
           end-if.
       end method.
      *>--------------------------------------------------------------------------------------------------------------<*
      *>/**
      *> Return true if button "Cancel" was selected
      *>
      *> @return boolean
      *>*/
       id division. method-id. actionCancel as "actionCancel".
       working-storage            section.
       77  outReturn              object reference JBoolean.
       procedure                  division returning outReturn.
           if w-return-cancel
              set  outReturn to   true,
           else,
              set  outReturn to   false,
           end-if.
       end method.
      *>--------------------------------------------------------------------------------------------------------------<*
      *>/**
      *> Return true if button "Ok" was selected
      *>
      *> @return boolean
      *>*/
       id division. method-id. actionOk as "actionOk".
       working-storage            section.
       77  outReturn              object reference JBoolean.
       procedure                  division returning outReturn.
           if w-buttons-ok or (w-buttons-okcancel and not w-return-cancel)
              set  outReturn to   true,
           else,
              set  outReturn to   false,
           end-if.
       end method.
       end object.
      *>--------------------------------------------------------------------------------------------------------------<*
