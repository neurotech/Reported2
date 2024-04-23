echo "Building Reported2 and installing to WoW directory."

echo "Creating TOC file."
touch Reported2.toc.tmp
cat Reported2.toc >Reported2.toc.tmp
sed -i "s/@project-version@/$(git describe --abbrev=0)/g" Reported2.toc.tmp

echo "Copying assets to WoW Classic installation directory."
mkdir -p /f/games/World\ of\ Warcraft/_classic_/Interface/AddOns/Reported2/
cp Reported2.toc.tmp /f/games/World\ of\ Warcraft/_classic_/Interface/AddOns/Reported2/Reported2.toc
cp *.lua /f/games/World\ of\ Warcraft/_classic_/Interface/AddOns/Reported2/
cp -r Fonts/ /f/games/World\ of\ Warcraft/_classic_/Interface/AddOns/Reported2/
cp -r Sounds/ /f/games/World\ of\ Warcraft/_classic_/Interface/AddOns/Reported2/
cp -r Textures/ /f/games/World\ of\ Warcraft/_classic_/Interface/AddOns/Reported2/

echo "Copying assets to WoW Retail installation directory."
mkdir -p /f/games/World\ of\ Warcraft/_retail_/Interface/AddOns/Reported2/
cp Reported2.toc.tmp /f/games/World\ of\ Warcraft/_retail_/Interface/AddOns/Reported2/Reported2.toc
cp *.lua /f/games/World\ of\ Warcraft/_retail_/Interface/AddOns/Reported2/
cp -r Fonts/ /f/games/World\ of\ Warcraft/_retail_/Interface/AddOns/Reported2/
cp -r Sounds/ /f/games/World\ of\ Warcraft/_retail_/Interface/AddOns/Reported2/
cp -r Textures/ /f/games/World\ of\ Warcraft/_retail_/Interface/AddOns/Reported2/

echo "Cleaning up."
rm Reported2.toc.tmp

echo "Complete."
