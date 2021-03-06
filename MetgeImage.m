clear;
Image_List = dir('Image\*.jpg');
Processed_Image_List = dir('Processed_Image\*.jpg')
Size = length(Image_List);

New_Im = zeros(0,0,3);

for i = 1:Size
    Im1 = imread([Image_List(i).folder ,'\',Image_List(i).name]);
    [Length,Width,Height] = size(Im1);
    [Length_New_Im,Width_New_Im,Height_New_Im] = size(New_Im);
    Scale = 640/Width;
    Im1 = imresize(Im1,Scale);
    [Length,Width,Height] = size(Im1);
    if Height == 1
        Im1(:,:,2) = Im1(:,:,1);
        Im1(:,:,3) = Im1(:,:,1);
    end
        for j = 1:3
            for k = 1:Length
                for l = 1:Width
                    New_Im(Length_New_Im + k,l,j) = Im1(k,l,j);
                end
            end
        end
    Im2 = imread([Processed_Image_List(i).folder,'\',Processed_Image_List(i).name]);
    [Length,Width,Height] = size(Im2);
    [Length_New_Im,Width_New_Im,Height_New_Im] = size(New_Im);
    Scale = 640/Width;
    Im2 = imresize(Im2,Scale);
    [Length,Width,Height] = size(Im2);
    if Height == 1
        Im2(:,:,2) = Im2(:,:,1);
        Im2(:,:,3) = Im2(:,:,1);
    end
        for j = 1:3
            for k = 1:Length
                for l = 1:Width
                    New_Im(Length_New_Im - Length + k,640 + l,j) = Im2(k,l,j);
                end
            end
        end
end
    
New_Im = uint8(New_Im);
imshow(New_Im);
imwrite(New_Im,'Merged_Image\Merged_Image.jpg')
