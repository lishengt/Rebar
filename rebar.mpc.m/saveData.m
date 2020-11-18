function saveData(type, out)
     
    column_bar = out{1};
    beam1_bar = out{2};
    beam2_bar = out{3};

    num_bar = size(beam1_bar, 2);
    if num_bar == 8
        beam1_bar_top = beam1_bar(5:8);
        beam1_bar_bottom = beam1_bar(1:4);
    elseif num_bar == 16
        beam1_bar_top = {beam1_bar(5:8), beam1_bar(13:16)};
        beam1_bar_bottom = {beam1_bar(1:4), beam1_bar(9:12)};
    end
    
    num_bar = size(beam2_bar, 2);
    if num_bar == 8
        beam2_bar_top = beam2_bar(5:8);
        beam2_bar_bottom = beam2_bar(1:4);
    elseif num_bar == 16
        beam2_bar_top = {beam2_bar(5:8), beam2_bar(13:16)};
        beam2_bar_bottom = {beam2_bar(1:4), beam2_bar(9:12)};
    end
  
   save(sprintf(".\\outputData\\%s\\%s.mat", type, 'column_bar'), 'column_bar');
   save(sprintf(".\\outputData\\%s\\%s.mat", type, 'beam1_bar_top'), 'beam1_bar_top');
   save(sprintf(".\\outputData\\%s\\%s.mat", type, 'beam1_bar_bottom'), 'beam1_bar_bottom');
   save(sprintf(".\\outputData\\%s\\%s.mat", type, 'beam2_bar_top'), 'beam2_bar_top');
   save(sprintf(".\\outputData\\%s\\%s.mat", type, 'beam2_bar_bottom'), 'beam2_bar_bottom');

end

