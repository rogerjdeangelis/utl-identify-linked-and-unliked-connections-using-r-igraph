%let pgm=utl-identify-linked-and-unliked-connections-using-r-igraph;

%stop_submission;

Identify linked and unliked connections using r igraph

hi res plot od linke and unliked nodes
https://tinyurl.com/3txjx7j7
https://github.com/rogerjdeangelis/utl-identify-linked-and-unliked-connections-using-r-igraph/blob/main/igraph.png

github
https://tinyurl.com/42xmds3s
https://github.com/rogerjdeangelis/utl-identify-linked-and-unliked-connections-using-r-igraph

communities.sas
https://tinyurl.com/45fj7ank
https://communities.sas.com/t5/New-SAS-User/Grouping-cases-by-shared-documents-direct-and-indirect/m-p/780346#M31624

Related repos
https://github.com/rogerjdeangelis/utl-identify-linked-and-unliked-paths-r-igraph
https://github.com/rogerjdeangelis/utl-linking-connected-nodes-in-a-network-graph-r-igraph
https://github.com/rogerjdeangelis/utl-linking-values-based-on-common-names
https://github.com/rogerjdeangelis/utl_count_tennis_pairs_on_multiple_teams_or_linked_groups
https://github.com/rogerjdeangelis/utl_group_linkage_number_of_times_one_item_has_been_grouped_together_with_another
https://github.com/rogerjdeangelis/utl_identify_linked_pairs_in_a_table_across_rows

I used this repo to convert the igraph to x y points (see end of message)
https://github.com/rogerjdeangelis/utl_digitize_data_from_image

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

/**************************************************************************************************************************/
/*       INPUT            |       PROCESS                    |   OUTPUT  https://tinyurl.com/3txjx7j7                     */
/*       =====            |       =======                    |   ======                                                   */
/*  SD1.HAVE total obs=16 | Simplest unlinked node           | FRO TOO  NODE                                              */
/*                        |                                  |                                                            */
/*   FRO    TOO           |           NODE                   | D1  C1   N1 -                                              */
/*                        | FRO TOO   ID                     | D1  C2   N1  | C                                           */
/*   D1     C1            |              -                   | D1  C3   N1  | O                                           */
/*   D1     C2            |  D6  C7   N3  |  Connected       | D2  C1   N1  | N                                           */
/*   D1     C3            |  D6  C8   N3  |                  | D2  C2   N1  | N                                           */
/*   D2     C1            |              -                   | D3  C1   N1  | E                                           */
/*   D2     C2            | D6 is only connected             | D3  C2   N1  | C                                           */
/*   D3     C1            | to C7 and C8                     | D3  C4   N1  | T                                           */
/*   D3     C2            |                                  | D7  C2   N1  | E                                           */
/*   D3     C4            | C7-D6-D8                         | D7  C9   N1 _| D                                           */
/*   D4     C5            |                                  |                                                            */
/*   D4     C6            | Gets complicated for other nodes | D4  C5   N2 -                                              */
/*   D5     C5            |                                  | D4  C6   N2  |                                             */
/*   D5     C6            | see graph                        | D5  C5   N2  |                                             */
/*   D6     C7            |                                  | D5  C6   N2 -                                              */
/*   D6     C8            |                                  |                                                            */
/*   D7     C2            |  proc datasets lib=sd1           |             -                                              */
/*   D7     C9            |    nolist nodetails;             | D6  C7   N3  |                                             */
/*                        |   delete want;                   | D6  C8   N3  |                                             */
/*                        |  run;quit;                       |             -                                              */
/*  options               |                                  |                                                           */
/*  validvarname=upcase;  |  %utlfkil("d:/png/igraphx.png"); |                 LINKED & UNLINKED NODES                    */
/*  libname sd1 "d:/sd1"; |                                  |                        X                                   */
/*  data sd1.have;        |  %utl_rbeginx;                   |     20       40       60       80      100                 */
/*     input fro $ too $; |  parmcards4;                     |  Y --+--------+--------+--------+------+--------------     */
/*  cards4;               |  library(haven);                 |   |                           /                       |    */
/*  D1 C1                 |  library(sqldf);                 | 80+    * C4              * C9/        FRO TOO  NODE  +80   */
/*  D1 C2                 |  library(igraph);                |   |                         /                      -  |    */
/*  D1 C3                 |  library(tidyverse);             |   |        * D3      * D7  /           D1  C1   N1 C| |    */
/*  D2 C1                 |  library(ggraph)                 |   |   +--+                /            D1  C2   N1 O| |    */
/*  D2 C2                 |  source("c:/oto/fn_tosas9x.R")   |   |   |N1|               /             D1  C3   N1 N| |    */
/*  D3 C1                 |  options(sqldf.dll =             |   |   +--+      * C2    / THREE NODES  D2  C1   N1 N| |    */
/*  D3 C2                 |    "d:/dll/sqlean.dll")          |   |        * C1        /  ===========  D2  C2   N1 E| |    */
/*  D3 C4                 |  have<-read_sas(                 | 60+                   /                D3  C1   N1 C| +60  */
/*  D4 C5                 |    "d:/sd1/have.sas7bdat")       |   |             * D2 /  +--+           D3  C2   N1 T| |    */
/*  D4 C6                 |  have                            |   |       * D1      /   |N2|   * C6    D3  C4   N1 E| |    */
/*  D5 C5                 |  g <-graph_from_data_frame(have) |   |                /    +--+           D7  C2   N1 D| |    */
/*  D5 C6                 |  png("d:/png/igraph.png" );      |   |               /\       * D5        D7  C9   N1 -  |    */
/*  D6 C7                 |  plot(g, vertex.label.cex=1)     |   |  * C3        /  \                                 |    */
/*  D6 C8                 |  png()                           |   |             /    \                 D4  C5   N2 -  |    */
/*  D7 C2                 |  comp <- components(g)$membership| 40+            /      \         * D4   D4  C6   N2  | +40  */
/*  D7 C9                 |  want<-have %>%                  |   |           /        \   * C5        D5  C5   N2  | |    */
/*  ;;;;                  |    mutate(group = comp[match(FRO,|   |          /   +--+   \              D5  C6   N2 -  |    */
/*  run;quit;             |     names(comp))]) %>%           |   |         /    |N3|    \                            |    */
/*                        |    mutate(id = first(FRO),       |   |        /     +--+     \                        -  |    */
/*                        |     .by = "group") %>%           |   |       /* C1            \            D6  C7  N3  | |    */
/*                        |    select(-group)                |   |      /    * D6          \           D6  C8  N3  | |    */
/*                        |  want;                           | 20+     /         * C8       \                     -  +20  */
/*                        |  fn_tosas9x(                     |   --+--------+--------+--------+-------+---------------    */
/*                        |        inp    = want             |    20       40       60       80      100                  */
/*                        |       ,outlib ="d:/sd1/"         |                       X                                    */
/*                        |       ,outdsn ="want"            |                 LINKED & UNLINKED NODES                    */
/*                        |       )                          |                                                            */
/*                        |  ;;;;                            |  https://tinyurl.com/3txjx7j7                              */
/*                        |  %utl_rendx;                     |                                                            */
/*                        |                                  |                                                            */
/*                        |  proc print data=sd1.want;       |                                                            */
/*                        |  run;quit;                       |                                                            */
/*                        |                                  |                                                            */
/**************************************************************************************************************************/

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

options
validvarname=upcase;
libname sd1 "d:/sd1";
data sd1.have;
   input fro $ too $;
cards4;
D1 C1
D1 C2
D1 C3
D2 C1
D2 C2
D3 C1
D3 C2
D3 C4
D4 C5
D4 C6
D5 C5
D5 C6
D6 C7
D6 C8
D7 C2
D7 C9
;;;;
run;quit;

/**************************************************************************************************************************/
/* SD1.HAVE total obs=16                                                                                                  */
/*                                                                                                                        */
/*   FRO    TOO                                                                                                           */
/*                                                                                                                        */
/*   D1     C1                                                                                                            */
/*   D1     C2                                                                                                            */
/*   D1     C3                                                                                                            */
/*   D2     C1                                                                                                            */
/*   D2     C2                                                                                                            */
/*   D3     C1                                                                                                            */
/*   D3     C2                                                                                                            */
/*   D3     C4                                                                                                            */
/*   D4     C5                                                                                                            */
/*   D4     C6                                                                                                            */
/*   D5     C5                                                                                                            */
/*   D5     C6                                                                                                            */
/*   D6     C7                                                                                                            */
/*   D6     C8                                                                                                            */
/*   D7     C2                                                                                                            */
/*   D7     C9                                                                                                            */
/**************************************************************************************************************************/

/*
 _ __  _ __ ___   ___ ___  ___ ___
| `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
*/


proc datasets lib=sd1
  nolist nodetails;
 delete want;
run;quit;

%utlfkil("d:/png/igraphx.png");

%utl_rbeginx;
parmcards4;
library(haven);
library(sqldf);
library(igraph);
library(tidyverse);
library(ggraph)
source("c:/oto/fn_tosas9x.R")
options(sqldf.dll =
  "d:/dll/sqlean.dll")
have<-read_sas(
  "d:/sd1/have.sas7bdat")
have
g <-graph_from_data_frame(have)
png("d:/png/igraph.png" );
plot(g, vertex.label.cex=1)
png()
comp <- components(g)$membership
want<-have %>%
  mutate(group = comp[match(FRO,
   names(comp))]) %>%
  mutate(id = first(FRO),
   .by = "group") %>%
  select(-group)
want;
fn_tosas9x(
      inp    = want
     ,outlib ="d:/sd1/"
     ,outdsn ="want"
     )
;;;;
%utl_rendx;

proc sort data=sd1.want;
  by id fro too;
run;quit;

proc print data=sd1.want;
run;quit;

/**************************************************************************************************************************/
/* Hi res graph   https://tinyurl.com/3txjx7j7                                                                            */
/*                                                                                                                        */
/*  SD1.WANT total obs=16                                                                                                 */
/*                                                                                                                        */
/*   FRO    TOO    ID                                                                                                     */
/*                                                                                                                        */
/*   D1     C1     D1                                                                                                     */
/*   D1     C2     D1                                                                                                     */
/*   D1     C3     D1                                                                                                     */
/*   D2     C1     D1                                                                                                     */
/*   D2     C2     D1                                                                                                     */
/*   D3     C1     D1                                                                                                     */
/*   D3     C2     D1                                                                                                     */
/*   D3     C4     D1                                                                                                     */
/*   D7     C2     D1                                                                                                     */
/*   D7     C9     D1                                                                                                     */
/*                                                                                                                        */
/*   D4     C5     D4                                                                                                     */
/*   D4     C6     D4                                                                                                     */
/*   D5     C5     D4                                                                                                     */
/*   D5     C6     D4                                                                                                     */
/*                                                                                                                        */
/*   D6     C7     D6                                                                                                     */
/*   D6     C8     D6                                                                                                     */
/**************************************************************************************************************************/

/*   _ _       _ _   _
  __| (_) __ _(_) |_(_)_______
 / _` | |/ _` | | __| |_  / _ \
| (_| | | (_| | | |_| |/ /  __/
 \__,_|_|\__, |_|\__|_/___\___|
         |___/
*/

I used this to convert the igraph to x y points
https://github.com/rogerjdeangelis/utl_digitize_data_from_image


    1. Open a dos command window
    2. Type R to bring up R editor
    3. Copy and paste teh code below
        library(digitize)
        tmp<-"d:/png/utl_dotplt.png"
        res<-digitize(tmp)
    4. Crossairs will appear on the image
        Define x y axis lengths
        click on X1 in the plot (lower left)
        wait a couple of seconds (1001 1002)
        click on X2
        wait a couple of seconds (1001 1002)
        click on Y1
        wait a couple of seconds (1001 1002)
        click on Y2
     5. Go to r command window answer questions
         Type x1 '40' <enter>
         Type x2 '160' <enter>
         Type Y1 '50' <enter>
         Type Y2 '75' <enter>
     6. Crosshairs will appear on plot
         click on the points (no wait?)
     7  Left click then
     7. Right click
        click on continue  (click stop when done)
     8. when all pint done  go to r command window
        type 'res'   (this will list the x,y points)
     9. save(res,file="d:/rda/res.rda")
        or cut and paste into sas create
        cards input


library(digitize)
tmp<-"d:/png/igraph.png"
res<-digitize(tmp)

data plt;
input x y;
num=_n_;
cards4;
33 25
43 23
54 21
72 37
82 41
82 53
71 49
23 46
33 53
48 56
36 62
46 66
36 74
58 75
27 80
68 79
;;;;
run;quit;

proc sort data=plt;
by y x;
run;quit;
                                      |
options FORMCHAR='|----|+|---+=|-/\<>*' ls=64 ps=32;
proc plot data=plt(rename=y=y12345678901234567890);
  plot y12345678901234567890*x='*' $ num/box;
run;quit;


    --+--------+--------+--------+--------+---
890 |                                        |
 80 +    * 15               * 16             +
    |                                        |
    |        * 13      * 14                  |
    |                                        |
    |                                        |
    |             * 12                       |
    |        * 11                            |
 60 +                                        +
    |              * 10                      |
    |       * 9                   * 6        |
    |                                        |
    |                        * 7             |
    |  * 8                                   |
    |                                        |
 40 +                             * 5        +
    |                        * 4             |
    |                                        |
    |                                        |
    |                                        |
    |       * 1                              |
    |           * 2                          |
 20 +                * 3                     +
    --+--------+--------+--------+--------+---
     20       40       60       80       100

                        X

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
