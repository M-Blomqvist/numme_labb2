function results = fixpunkt(guesses, theta_f, accuracy)
  %Använder theta_f funktionen som fixpunkt-funktion
  %för att hitta rötter, funkar med flera dimensioner
  %Ger en array av hittade fixpunkter, avbryter efter max 100 iterationer
  results = NaN(size(guesses));
  do_print = 1;
  
  for g = 1:size(guesses,2)
    x = guesses(:,g);
    %tillfälliga värden för att se till att loopen körs en gång
    diff = 2;
    last_diff = NaN;
    i = 1;
    if do_print
      fprintf('\n Finding root at: [%s] \n', sprintf('%d,',x));
    end
    while diff > accuracy && i < 100
      %Hitta nästa x och skillnaden xn+1 - xn
      next = theta_f(x);
      %Norm för att tillåta vektorer & gör abs automatiskt
      diff = norm(next - x);
      S = diff/last_diff;
      if do_print
        fprintf('S = %d \n Iter: %d v: [%s] diff: %d \n', S, i, sprintf('%d,',next), diff);
      end
      x = next;
      last_diff = diff;
      i = i+1;
    end
    results(:,g) = x;
  end
end