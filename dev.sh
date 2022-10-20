echo "Building Reported2 and installing to WoW directory."

echo "Creating TOC file."
touch Reported2.toc.tmp
cat Reported2.toc > Reported2.toc.tmp
sed -i "s/@project-version@/$(git describe --abbrev=0)/g" Reported2.toc.tmp

echo "Copying assets to WoW installation directory."
mkdir -p /h/games/World\ of\ Warcraft/_classic_/Interface/AddOns/Reported2/
cp Reported2.toc.tmp /h/games/World\ of\ Warcraft/_classic_/Interface/AddOns/Reported2/Reported2.toc
cp *.lua /h/games/World\ of\ Warcraft/_classic_/Interface/AddOns/Reported2/
cp -r Fonts/ /h/games/World\ of\ Warcraft/_classic_/Interface/AddOns/Reported2/
cp -r Sounds/ /h/games/World\ of\ Warcraft/_classic_/Interface/AddOns/Reported2/
cp -r Textures/ /h/games/World\ of\ Warcraft/_classic_/Interface/AddOns/Reported2/

echo "Cleaning up."
rm Reported2.toc.tmp

echo "Complete."