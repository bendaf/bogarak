%% Robotika nagy h�zi feladat konzult�ci�
    % 2014.12.02.
%% Objektumok l�trehoz�sa

% Hasonl� m�don kell objektumokat l�trehozni, mint pl. C++-ban, ugyan�gy
% megvannak a tagf�ggv�nyek, tagv�ltoz�k, szintaktik�ra neten r� kell
% keresni.
% Van debugger a Matlabban, �rdemes haszn�lni.
% Matlab nem t�pusos, figyelni kell, hogy ne adjunk �rt�k�l valami m�s
% objektumnak valamit...
% Cellat�mb: 
    % nem csak egyszer� t�pusokat lehet benne t�rolni, hanem komplex
    % elemeket, �rdemes egy cellat�mbben p�ld�ul a bogarakat t�rolni, m�sik
    % t�mbben pedig a kaj�kat, m�sikban akad�lyokat stb...
% Lehetne �gy is, hogy elt�rolom az �sszes objektumomat (bog�r, kaja,
% akad�ly), de nem tan�csos, mert minden cellael�r�skor a t�pust ellen�rzni
% kell �s bonyolultt� is v�lhat.

%% �tkeres�s, algoritmusok

% �tkeres� algoritmus implement�l�sa a 6. feladathoz (A*, depht-first, stb)
    % Megval�s�t�s:
    % Egy queue-ban kell elt�rolni egy pontb�l a lehets�ges �tir�nyokat
    % pl van A,B,C pontok, queueb�l kiveszem az els� elemet, kinyitom az
    % A-b�l vezet� utakat �s a queue v�g�re f�z�m, azt�n megint kiveszem az
    % els� elemet �s �gy tov�bb, ezzel egy sz�less�gi keres�st val�s�tottam
    % meg. Azt�n ha a queue elej�re f�z�m az �j csom�pontokat, nem pedig a
    % v�g�re, akkor pedig is m�lys�gi keres�t val�s�tottunk meg. Ezt m�g
    % lehet �gy kombin�lni, hogy azt a csom�pontot nyitom ki, ahol a
    % legkisebb az euklideszi t�vols�g a c�lhoz k�pest, ehhez rendezni kell
    % a queue-t.

% Potenci�l t�r alap� vez�rl�s - legr�videbb �thoz
    % Az x,y koordin�t�khoz van egy harmadik �rt�k is rendelve, az �
    % potenci�lja. �gy �rdemes ezt csin�lni, hogy a kaj�nak alacsony legyen 
    % a potenci�lja, a t�bbi pontnak a potenci�lja meg magasabb. �gy 
    % kialakul egy potenci�lt�r, amely a kaja fel� fog lejteni. Majd ezek 
    % ut�n gradiens keres�ssel meg lehet tal�lni a kaj�t.
    
    % Probl�ma a k�vetkez� helyzetben mer�l fel: a kaja fel� lejt a t�r, �s
    % azt l�tjuk abb�l a helyzetb�l, hogy j� lesz az az ir�ny nek�nk. 
    % Azonban a c�l �s a kaja k�z�tt van egy "U" alak� potenci�lt�r �s ott 
    % van egy lok�lis minimum, oda beragadhat. Erre kellene kital�lni 
    % valami megold�st, hogy hogyan ne ragadjon oda be.

%% Plot, �br�zol�s, szimul�ci�

% Kirajozl�st k�tf�lek�ppen is meg lehet oldani. Egyik megold�s, hogy
% kirajzolod az aktu�lis �llapotot �s azt�n bizonyos id�k�z�nk�nt friss�ted
% a ploton a k�pet. Ezzel lehet probl�ma, hogy villogni fog a k�p, ez�rt
% ut�na kell n�zni olyan parancsnak, hogy freeze...Ezzel valahogy majdnem 
% folytonoss� tenni az �br�zol�st.
% M�sik megold�s az lehet, hogy egy plotod van, �s a rajta l�v� pontokat
% friss�ted mindig direktben.
% Az el�z� megold�s jobbnak t�nik.

%% Plusz feladatok 60% f�l�tti eredm�nyhez

% Lehet m�s feladatokat kital�lni a 60% f�l�tti eredm�nyhez, de meg kell 
% vele besz�lni �s megmondja, hogy komplexit�s szempontj�b�l milyen a 
% feladat �s h�ny %-ot tud r� adni.