%% Robotika nagy házi feladat konzultáció
    % 2014.12.02.
%% Objektumok létrehozása

% Hasonló módon kell objektumokat létrehozni, mint pl. C++-ban, ugyanúgy
% megvannak a tagfüggvények, tagváltozók, szintaktikára neten rá kell
% keresni.
% Van debugger a Matlabban, érdemes használni.
% Matlab nem típusos, figyelni kell, hogy ne adjunk értékül valami más
% objektumnak valamit...
% Cellatömb: 
    % nem csak egyszerû típusokat lehet benne tárolni, hanem komplex
    % elemeket, érdemes egy cellatömbben például a bogarakat tárolni, másik
    % tömbben pedig a kajákat, másikban akadályokat stb...
% Lehetne úgy is, hogy eltárolom az összes objektumomat (bogár, kaja,
% akadály), de nem tanácsos, mert minden cellaeléréskor a típust ellenõrzni
% kell és bonyolulttá is válhat.

%% Útkeresés, algoritmusok

% Útkeresõ algoritmus implementálása a 6. feladathoz (A*, depht-first, stb)
    % Megvalósítás:
    % Egy queue-ban kell eltárolni egy pontból a lehetséges útirányokat
    % pl van A,B,C pontok, queueból kiveszem az elsõ elemet, kinyitom az
    % A-ból vezetõ utakat és a queue végére fûzöm, aztán megint kiveszem az
    % elsõ elemet és így tovább, ezzel egy szélességi keresést valósítottam
    % meg. Aztán ha a queue elejére fûzöm az új csomópontokat, nem pedig a
    % végére, akkor pedig is mélységi keresét valósítottunk meg. Ezt még
    % lehet úgy kombinálni, hogy azt a csomópontot nyitom ki, ahol a
    % legkisebb az euklideszi távolság a célhoz képest, ehhez rendezni kell
    % a queue-t.

% Potenciál tér alapú vezérlés - legrövidebb úthoz
    % Az x,y koordinátákhoz van egy harmadik érték is rendelve, az õ
    % potenciálja. Úgy érdemes ezt csinálni, hogy a kajának alacsony legyen 
    % a potenciálja, a többi pontnak a potenciálja meg magasabb. Így 
    % kialakul egy potenciáltér, amely a kaja felé fog lejteni. Majd ezek 
    % után gradiens kereséssel meg lehet találni a kaját.
    
    % Probléma a következõ helyzetben merül fel: a kaja felé lejt a tér, és
    % azt látjuk abból a helyzetbõl, hogy jó lesz az az irány nekünk. 
    % Azonban a cél és a kaja között van egy "U" alakú potenciáltér és ott 
    % van egy lokális minimum, oda beragadhat. Erre kellene kitalálni 
    % valami megoldást, hogy hogyan ne ragadjon oda be.

%% Plot, ábrázolás, szimuláció

% Kirajozlást kétféleképpen is meg lehet oldani. Egyik megoldás, hogy
% kirajzolod az aktuális állapotot és aztán bizonyos idõközönként frissíted
% a ploton a képet. Ezzel lehet probléma, hogy villogni fog a kép, ezért
% utána kell nézni olyan parancsnak, hogy freeze...Ezzel valahogy majdnem 
% folytonossá tenni az ábrázolást.
% Másik megoldás az lehet, hogy egy plotod van, és a rajta lévõ pontokat
% frissíted mindig direktben.
% Az elõzõ megoldás jobbnak tûnik.

%% Plusz feladatok 60% fölötti eredményhez

% Lehet más feladatokat kitalálni a 60% fölötti eredményhez, de meg kell 
% vele beszélni és megmondja, hogy komplexitás szempontjából milyen a 
% feladat és hány %-ot tud rá adni.