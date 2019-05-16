%Code used for graphing in papers and presentations

%     if i==1
%         figure(1);plot(t,y(1,:),'b','LineWidth',2);hold on;
%         xlabel('Days','FontSize',15);ylabel('S(t)','FontSize',15)
%         LegendS{1} = 'No Control';
%         figure(2);plot(t,y(2,:),'b','LineWidth',2);hold on;
%         xlabel('Days','FontSize',15);ylabel('E(t)','FontSize',15)
%         LegendE{1} = 'No Control';
%         figure(3);plot(t,y(3,:),'b','LineWidth',2);hold on;
%         xlabel('Days','FontSize',15);ylabel('I(t)','FontSize',15)
%         LegendI{1} = 'No Control';
%         figure(4);plot(t,y(4,:),'b','LineWidth',2);hold on;
%         xlabel('Days','FontSize',15);ylabel('R(t)','FontSize',15)
%         LegendR{1} = 'No Control';
%     end
%     if i==fin
%         figure(1);plot(t,y(1,:),'r','LineWidth',2)
%         LegendS{2} = 'Control'; legend(LegendS);
%         set(gca,'FontSize',15)
%         figure(2);plot(t,y(2,:),'r','LineWidth',2)
%         LegendE{2} = 'Control'; legend(LegendE);
%         set(gca,'FontSize',15)
%         figure(3);plot(t,y(3,:),'r','LineWidth',2)
%         LegendI{2} = 'Control'; legend(LegendI);
%         set(gca,'FontSize',15)
%         figure(4);plot(t,y(4,:),'r','LineWidth',2)
%         LegendR{2} = 'Control';legend(LegendR);
%         set(gca,'FontSize',15)
%         figure(5);plot(t,v,'r',t,q,'b','LineWidth',2);
%         xlabel('Days','FontSize',15);
%         legend('Vaccination','Quarantine')
%         set(gca,'FontSize',15)
%     end




%code with subplots
%     if i==1
%         figure(1);
%         subplot(3,2,1);plot(t,y(1,:),'b','LineWidth',2);hold on;
%         xlabel('Days','FontSize',15);ylabel('S(t)','FontSize',15)
%         LegendS{1} = 'No Control';
%         subplot(3,2,2);plot(t,y(2,:),'b','LineWidth',2);hold on;
%         xlabel('Days','FontSize',15);ylabel('E(t)','FontSize',15)
%         LegendE{1} = 'No Control';
%         subplot(3,2,3);plot(t,y(3,:),'b','LineWidth',2);hold on;
%         xlabel('Days','FontSize',15);ylabel('I(t)','FontSize',15)
%         LegendI{1} = 'No Control';
%         subplot(3,2,4);plot(t,y(4,:),'b','LineWidth',2);hold on;
%         xlabel('Days','FontSize',15);ylabel('R(t)','FontSize',15)
%         LegendR{1} = 'No Control';
%     end
%     if i==fin
%         figure(1);
%         subplot(3,2,1);plot(t,y(1,:),'r','LineWidth',2)
%         LegendS{2} = 'Control'; legend(LegendS);
%         set(gca,'FontSize',15)
%         subplot(3,2,2);plot(t,y(2,:),'r','LineWidth',2)
%         LegendE{2} = 'Control'; legend(LegendE);
%         set(gca,'FontSize',15)
%         subplot(3,2,3);plot(t,y(3,:),'r','LineWidth',2)
%         LegendI{2} = 'Control'; legend(LegendI);
%         set(gca,'FontSize',15)
%         subplot(3,2,4);plot(t,y(4,:),'r','LineWidth',2)
%         LegendR{2} = 'Control';legend(LegendR);
%         set(gca,'FontSize',15)
%         figure(2);plot(t,v,'r',t,q,'b','LineWidth',2);
%         xlabel('Days','FontSize',15);
%         legend('V','Q')
%         set(gca,'FontSize',15)