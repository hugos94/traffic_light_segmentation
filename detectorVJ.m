function detectorVJ()

%Criar arquivo .mat para o detector
%trainingImageLabeler

%Pasta com a imagens que não contem semaforos
negativeFolder = fullfile('/home/labinc/Desktop/traffic_light_segmentation-master/negativeFolder');

%Treina o detector criando o arquivo 'trafficLightDetector.xml'
trainCascadeObjectDetector('trafficLightDetector.xml',positiveInstances,negativeFolder,'FalseAlarmRate',0.2,'NumCascadeStages',5);

%Salva o detector
detector = vision.CascadeObjectDetector('trafficLightDetector.xml');

n = 10

for i = 1:n
    %Le a imagem RGB
    rgb = imread([num2str(i) '.jpg']);
    
    %Armazena as informacoes de altura e largura
    [altura,largura] = size(rgb);
    
    %Corta a metade da imagem pra reduzir a area de busca
    rgb_cropped = imcrop(rgb,[0 0 largura (altura/2)]);

    %Inicia o detector
    bbox = step(detector, rgb_cropped);
	
    %Insere as anotacoes na imagem analisada
    detectedImg = insertObjectAnnotation(rgb_cropped, 'rectangle', bbox, 'traffic light');
    
    %mostra a imagem
    figure; imshow(detectedImg);
end

end
