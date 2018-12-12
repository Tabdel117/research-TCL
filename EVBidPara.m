function [ Pmax,Pmin,Pavg ] = EVBidPara( T,E,alpha,t,E_min,E_max,PN ) %tΪʣ��ʱ��
E_avg=alpha*E_max+(1-alpha)*E_min;
% E_avg=E_min;
%�ú�������EV��E,�û��趨����Ϣ,����alpha,E_min,E_max,t
%������EV��Ͷ�����Pmax,Pmin,Pavg
%type 1
if t<T
    Pmax=0;Pmin=0;Pavg=0;
    return;
end
tleft=floor(t/T);
if E_min-E>0 && E_min-E<(tleft-1)*T*PN
    Pmin=0;
    Pmax=min(PN,(E_max-E)/T);
    Pavg=min((E_avg-E)/tleft/T,Pmax);
elseif E_min-E>(tleft-1)*T*PN && E_min-E<tleft*T*PN
    if alpha<PN*T/(E_max-E_min)
        Pmin=(E_min-E)/tleft/T;
        Pmax=min(PN,(E_max-E)/T);
        Pavg=min(Pmax,(E_avg-E)/tleft/T);
    else
        Pmin=(E_min-E)/tleft/T;
        Pmax=min(PN,(E_max-E)/T);
        Pavg=min(PN,Pmax);
        Pavg=max(Pavg,Pmin);
    end
elseif  E_min-E>tleft*T*PN
    Pmin=PN;
    Pmax=min(PN,(E_max-E)/T);
    Pavg=min(PN,Pmax);
    Pavg=max(Pavg,Pmin);
else
    Pmin=0;
    tmp=max(0,(E_avg-E)/tleft/T);
    Pavg=min(PN,tmp);
    Pmax=min(PN,(E_max-E)/T);
    Pmax=max(0,Pmax);
    
    % Pmax=Pavg;
    % Pavg=0;
    % Pmin=0;
    
end
%���ӻ�
% if td-ta>=t
%     EVagent(T,ta,td,td-t,E_min,E_max,E,alpha,PN,Pmax,Pmin,Pavg );
% end
end

