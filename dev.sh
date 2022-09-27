touch Reported2-Retail.toc Reported2-Classic.toc

cat Reported2.toctemplate > Reported2.toctemplate.tmp

sed -i "s/ADDON_VERSION/$(git describe --abbrev=0)/g" Reported2.toctemplate.tmp

cat Reported2.toctemplate.tmp > Reported2-Retail.toc
cat Reported2.toctemplate.tmp > Reported2-Classic.toc

sed -i "s/INTERFACE_VERSION/$(cat ./versions/retail)/g" Reported2-Retail.toc
sed -i "s/INTERFACE_VERSION/$(cat ./versions/classic)/g" Reported2-Classic.toc

mkdir -p /h/games/World\ of\ Warcraft/_retail_/Interface/AddOns/Reported2/
mkdir -p /h/games/World\ of\ Warcraft/_classic_/Interface/AddOns/Reported2/

cp *.lua *.mp3 *.tga *.ttf /h/games/World\ of\ Warcraft/_retail_/Interface/AddOns/Reported2/
cp Reported2-Retail.toc /h/games/World\ of\ Warcraft/_retail_/Interface/AddOns/Reported2/

cp *.lua *.mp3 *.tga *.ttf /h/games/World\ of\ Warcraft/_classic_/Interface/AddOns/Reported2/
cp Reported2-Classic.toc /h/games/World\ of\ Warcraft/_classic_/Interface/AddOns/Reported2/
cp Reported2-Classic.toc /h/games/World\ of\ Warcraft/_classic_/Interface/AddOns/Reported2/Reported2-BCC.toc
cp Reported2-Classic.toc /h/games/World\ of\ Warcraft/_classic_/Interface/AddOns/Reported2/Reported2-WOTLKC.toc

rm Reported2.toctemplate.tmp
rm Reported2-Retail.toc
rm Reported2-Classic.toc