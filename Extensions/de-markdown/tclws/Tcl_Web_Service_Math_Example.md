# Mathematikbeispiel eines Tcl-Webdienstes

## Serverseite

Das Folgende steht in httpdthread.tcl:

```
   package require WS::Server
   package require WS::Utils
```

Das Folgende steht in eine Datei im Verzeichnis custom:

```
    ##
    ## Den Dienst definieren
    ##
    ::WS::Server::Service \
        -service wsMathExample \
        -description  {Tcl Web Services Math Example} \
        -host         $::Config(host):$::Config(port)

    ##
    ## Besondere Typen definieren
    ##
    ::WS::Utils::ServiceTypeDef Server wsMathExample Term {
       `coef         {type float}
        powerTerms   {type PowerTerm()}
    }
    ::WS::Utils::ServiceTypeDef Server wsMathExample PowerTerm {
        var          {type string}
        exponet      {type float}
    }
    ::WS::Utils::ServiceTypeDef Server wsMathExample Variables {
        var          {type string}
        value        {type float}
    }

   ##
   ## Die verfügbaren Operationen definieren
   ##
   ::WS::Server::ServiceProc \
        wsMathExample \
        {EvaluatePolynomial {type float comment {Result of evaluating a polynomial}}} \
        {
            varList       {type Variables() comment {The variables to be substitued into the polynomial}}
            polynomial    {type Term() comment {The polynomial}}
        } \
        {Evaluate a polynomial} {
        set equation {0 }
        foreach varDict $varList {
            set var [dict get $varDict var]
            set val [dict get $varDict value]
            set vars($var) $val
        }
        foreach term $polynomial {
            if {[dict exists $term coef]} {
                set coef [dict get $term coef]
            } else {
                set coef 1
            }
            append equation "+ ($coef"
            foreach pow [dict get $term powerTerms] {
                if {[dict exists $pow exponet]} {
                    set exp [dict get $pow exponet]
                } else {
                    set exp 1
                }
                append equation [format { * pow($vars(%s),%s} [dict get $pow var] $exp]
            }
            append equation ")"
        }
        set result [expr $equation]
        return [list SimpleEchoResult $result]
    }
```

  


## Clientseite

```
    package require WS::Client
    ##
    ## Definition der angebotenen Dienste holen
    ##
    ::WS::Client::GetAndParseWsdl http://localhost:8015/service/wsMathExamples/wsdl

    dict set term var X
    dict set term value 2.0
    dict lappend varList $term
    dict set term var Y
    dict set term value 3.0
    dict lappend varList $term

    set term {}
    set powerTerm {}
    dict set powerTerm coef 2.0
    dict set term var X
    dict set term pow 2.0
    dict lappend terms $term
    dict set term var Y
    dict set term pow 3.0
    dict lappend terms $term
    dict set powerTerm powerTerms $terms

    dict set powerTerm coef -2.0
    dict set term var X
    dict set term pow 3.0
    dict lappend terms $term
    dict set term var Y
    dict set term pow 2.0
    dict lappend terms $term
    dict set powerTerm powerTerms $terms
    dict lappend polynomial powerTerms $powerTerm

    dict set input [list varList $varList polynomial $polynomial]
    ##
    ## Dienst aufrufen
    ##
    puts stdout "Calling EvaluatePolynomial wiht {$input}"
    set resultsDict [::WS::Client::DoCall wsMathExample EvaluatePolynomial $input]
    puts stdout "Results are {$resultsDict}"
```
