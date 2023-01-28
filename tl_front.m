clc
close all
clear

para = imread("200_tl_ön.jpg");
figure(1);
subplot(3,2,1);
imshow(para);
para_gri = rgb2gray(para);
subplot(3,2,2);
imshow(para_gri);

boy = 512; en = 512;
para_small = imresize(para_gri, [boy en]);
subplot(3,2,3);
imshow(para_small)

para_small = double(para_small);
para_normal = (para_small - min(para_small(:))) / (max(para_small(:)) - min(para_small(:)));
subplot(3,2,4);
imshow(para_normal)

para_denoyz= medfilt2(para_normal);
subplot(3,2,5);
imshow(para_denoyz)

para_hist = histeq(para_denoyz);
subplot(3,2,6);
imshow(para_hist)


%% ORTA SAYI
para_gray_cropped_onyuzorta = para_hist(round(boy*0.34):round(boy*0.50),round(en*0.32):round(en*0.5));
figure(2);
subplot(1,2,1);
imshow(para_gray_cropped_onyuzorta)

threshold_onyuzorta = graythresh(para_gray_cropped_onyuzorta);
para_binary_cropped_onyuzorta = imbinarize(para_gray_cropped_onyuzorta,"global");
subplot(1,2,2);
imshow(para_binary_cropped_onyuzorta)

m_orta =ocr(para_binary_cropped_onyuzorta,'CharacterSet','0125','TextLayout','word');
disp("Orta");
disp(m_orta.Words);

%% SOL ALT SAYI
para_gray_cropped_onyuzsolalt = para_hist(round(boy*0.68):round(boy*0.97),1:round(en*0.25));
figure(3);
subplot(1,2,1);
imshow(para_gray_cropped_onyuzsolalt)

threshold_onyuzsolalt = graythresh(para_gray_cropped_onyuzsolalt);
para_binary_cropped_onyuzsolalt = imbinarize(para_gray_cropped_onyuzsolalt,"global");
subplot(1,2,2);
imshow(para_binary_cropped_onyuzsolalt)

m_solalt =ocr(para_binary_cropped_onyuzsolalt,'CharacterSet','0125','TextLayout','word');
disp("Sol Alt");
disp(m_solalt.Words);

%% ORTA YAZI
para_gray_cropped_onyuzortayazi = para_hist(round(boy*0.50):round(boy*0.65),round(en*0.30):round(en*0.55));
figure(4);
subplot(1,2,1);
imshow(para_gray_cropped_onyuzortayazi)

threshold_onyuzortayazi = graythresh(para_gray_cropped_onyuzortayazi);
para_binary_cropped_onyuzortayazi = imbinarize(para_gray_cropped_onyuzortayazi,"global");
subplot(1,2,2);
imshow(para_binary_cropped_onyuzortayazi)

m_ortayazi =ocr(para_binary_cropped_onyuzortayazi,'CharacterSet','ABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZ','TextLayout','word');
disp("Ortayazi");
disp(m_ortayazi.Words);

