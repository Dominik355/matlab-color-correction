function zadaneFarby = zadanieFarieb()

prompt = {'Number of colors :'};
dlgtitle = 'Input';
answer = inputdlg(prompt,dlgtitle)
a = str2num(answer{1,1});
for i = 1:a
    string= ['Name of color ' num2str(i) ' :'];
    zadaneFarby(i) = inputdlg(string, 'Input');
end
end

