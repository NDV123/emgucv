cd ../..
rm -rf tmp
git archive --format=tar --prefix=tmp/ HEAD | tar xf -
cd platforms/ios

rm -rf ios-package
mkdir ios-package
cp -r ../../tmp/Emgu.CV ios-package/Emgu.CV
cp -f ../../Emgu.CV/*.cs ios-package/Emgu.CV/
rm -rf ios-package/Emgu.CV/PInvoke/Android
rm -rf ios-package/Emgu.CV/PInvoke/System.Drawing
rm -rf ios-package/Emgu.CV/PInvoke/Windows.Store
rm -rf ios-package/Emgu.CV/PInvoke/Unity
cp -rf ../../Emgu.CV/PInvoke/iOS/libemgucv.a ios-package/Emgu.CV/PInvoke/iOS
cp ../../Emgu.CV/PInvoke/CvInvokeEntryPoints.cs ios-package/Emgu.CV/PInvoke
cp -f ../../Emgu.CV/Util/*.cs ios-package/Emgu.CV/Util

cp -r ../../tmp/Emgu.CV.ML ios-package/Emgu.CV.ML
cp -f ../../Emgu.CV.ML/*.cs ios-package/Emgu.CV.ML/
cp -r ../../tmp/Emgu.CV.OCR ios-package/Emgu.CV.OCR
cp -r ../../tmp/Emgu.CV.Stitching ios-package/Emgu.CV.Stitching
cp -r ../../tmp/Emgu.Util ios-package/Emgu.Util
cp -r ../../tmp/Emgu.CV.Cuda ios-package/Emgu.CV.Cuda
cp -f ../../Emgu.CV.Cuda/*.cs ios-package/Emgu.CV.Cuda/
cp -r ../../tmp/Emgu.CV.Shape ios-package/Emgu.CV.Shape
cp -r ../../tmp/Emgu.CV.Contrib ios-package/Emgu.CV.Contrib
cp -f ../../Emgu.CV.Contrib/Text/VectorOf*.cs ios-package/Emgu.CV.Contrib/Text
cp -f ../../Emgu.CV.OCR/*.cs ios-package/Emgu.CV.OCR/

mkdir -p ios-package/Solution/iOS
cp ../../tmp/Solution/iOS/Emgu.CV.iOS.sln ios-package/Solution/iOS/Emgu.CV.iOS.sln

mkdir -p ios-package/Emgu.CV.Example/SURFFeature
mkdir -p ios-package/Emgu.CV.Example/PlanarSubdivision
mkdir -p ios-package/Emgu.CV.Example/LicensePlateRecognition
mkdir -p ios-package/Emgu.CV.Example/PedestrianDetection
mkdir -p ios-package/Emgu.CV.Example/TrafficSignRecognition
mkdir -p ios-package/Emgu.CV.Example/FaceDetection
mkdir -p ios-package/opencv/data/haarcascades
cp -r ../../tmp/Emgu.CV.Example/iOS ios-package/Emgu.CV.Example/iOS
cp ../../tmp/Emgu.CV.Example/SURFFeature/box.png ios-package/Emgu.CV.Example/SURFFeature/box.png
cp ../../tmp/Emgu.CV.Example/SURFFeature/box_in_scene.png ios-package/Emgu.CV.Example/SURFFeature/box_in_scene.png
cp ../../tmp/Emgu.CV.Example/SURFFeature/DrawMatches.cs ios-package/Emgu.CV.Example/SURFFeature/DrawMatches.cs
cp ../../tmp/Emgu.CV.Example/PlanarSubdivision/DrawSubdivision.cs ios-package/Emgu.CV.Example/PlanarSubdivision/DrawSubdivision.cs
cp ../../tmp/Emgu.CV.Example/LicensePlateRecognition/license-plate.jpg ios-package/Emgu.CV.Example/LicensePlateRecognition/license-plate.jpg
cp ../../tmp/Emgu.CV.Example/LicensePlateRecognition/LicensePlateDetector.cs ios-package/Emgu.CV.Example/LicensePlateRecognition/LicensePlateDetector.cs
cp ../../tmp/Emgu.CV.Example/PedestrianDetection/pedestrian.png ios-package/Emgu.CV.Example/PedestrianDetection/pedestrian.png
cp ../../tmp/Emgu.CV.Example/PedestrianDetection/FindPedestrian.cs ios-package/Emgu.CV.Example/PedestrianDetection/FindPedestrian.cs
cp ../../tmp/Emgu.CV.Example/TrafficSignRecognition/stop-sign.jpg ios-package/Emgu.CV.Example/TrafficSignRecognition/stop-sign.jpg
cp ../../tmp/Emgu.CV.Example/TrafficSignRecognition/stop-sign-model.png ios-package/Emgu.CV.Example/TrafficSignRecognition/stop-sign-model.png
cp ../../tmp/Emgu.CV.Example/TrafficSignRecognition/StopSignDetector.cs ios-package/Emgu.CV.Example/TrafficSignRecognition/StopSignDetector.cs
cp ../../tmp/Emgu.CV.Example/FaceDetection/lena.jpg ios-package/Emgu.CV.Example/FaceDetection/lena.jpg
cp ../../tmp/Emgu.CV.Example/FaceDetection/DetectFace.cs ios-package/Emgu.CV.Example/FaceDetection/DetectFace.cs
cp ../../opencv/data/haarcascades/haarcascade_eye.xml ios-package/opencv/data/haarcascades/haarcascade_eye.xml
cp ../../opencv/data/haarcascades/haarcascade_frontalface_default.xml ios-package/opencv/data/haarcascades/haarcascade_frontalface_default.xml
cp ../../CommonAssemblyInfo.cs ios-package
find ./ios-package -type f -name CMakeList* -exec rm '{}' \;
find ./ios-package -type f -name *Android* -exec rm '{}' \;
find ./ios-package -type f -name *Windows.Store* -exec rm '{}' \;
find ./ios-package -type f -name *Windows.Phone* -exec rm '{}' \;
cd ios-package
rm Emgu.CV/Emgu.CV.csproj Emgu.CV.ML/Emgu.CV.ML.csproj Emgu.CV.Cuda/Emgu.CV.Cuda.csproj Emgu.CV.OCR/Emgu.CV.OCR.csproj Emgu.Util/Emgu.Util.csproj Emgu.CV.Stitching/Emgu.CV.Stitching.csproj Emgu.CV.Contrib/Emgu.CV.Contrib.csproj Emgu.CV.Shape/Emgu.CV.Shape.csproj
#find . -regex  '.*[^S].csproj' -exec rm '{}' \;
cd ..

gitversion=$(git log --oneline | wc -l | tr -d " ")
zip -r libemgucv-ios-unified-$gitversion ios-package