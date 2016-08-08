class Parser
prechigh
  nonassoc UMINUS
  left '('
  left '['
  left '::'
  left '*'
  left '+'
  right '='
  nonassoc ','
  right ')'
preclow
start root
rule

  root: exp

  exp: exp '+' exp                  # +
    | exp '*' exp                   # *
    | '-' exp =UMINUS               # -1
    | id | string | int             # id "str" 1
    | id '=' exp                    # assignment
    | '(' exp ')'                   # (exp)
    | '->(' args '){' exp_list '}'  # function definition
    | id '(' exp_clist ')'          # function call
    | '[' exp_list ']'              # list definition
    | '{' map_list '}'              # map definition
    | exp '[' exp_clist ']'         # [] operator
    | 'module' '{' exp_list '}'     # module definition
    | id_list                       # scope operator
    | 'if' exp '{' exp_list '}' 'else' '{' exp_list '}' # if else
  
  exp_list: 
    | exp ";" exp_list
  args:
    | id "," args
  exp_clist: 
    | exp ',' exp_clist
  id_list: id '::' id
    | id '::' id_list
  map_list: 
    | id ":" exp "," map_list


  id: 'id'
  string: 's'
  int: '1'
