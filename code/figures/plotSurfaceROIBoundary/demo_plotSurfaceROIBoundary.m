% This demonstration is to show the different way this code can plot the
% ROI boundaries

load('example_surface_data.mat','lh_inflated_verts','lh_verts','lh_faces','lh_HCPMMP1','lh_aparc','lh_rand200','lh_sulc')

surface.vertices = lh_inflated_verts;
surface.faces = lh_faces;

figure

ax1 = axes('Position',[0.01 0 .3 1]);

% This just plots the ROI ID number for each ROI

plotSurfaceROIBoundary(surface,lh_rand200,1:100,'faces',jet(100),1,2);

% The following options set up the patch object to look pretty. This works
% well for the left hemisphere (medial and lateral). Change the inputs to 
% 'view' to see the brain from different angles ([-90 0] for left and [90 0]
% for right I find works well)

camlight(80,-10);
camlight(-80,-10);
view([-90 0])
axis off
axis tight
axis equal

ax2 = axes('Position',[0.01+(1/3) 0 .3 1]);

cmap = flipud(hot(130));

% Just make up some data for the example illustration. This represents some
% value for each ROI
random_data = normpdf(1:180,100,100);

plotSurfaceROIBoundary(surface,lh_HCPMMP1,random_data,'midpoint',cmap(1:100,:),1,2);
camlight(80,-10);
camlight(-80,-10);

view([90 0])

axis off
axis tight
axis equal

ax3 = axes('Position',[0.01+(2/3) 0 .3 1]);

% This plots sulcal depth, which is defined for each vertex

surface.vertices = lh_verts;
plotSurfaceROIBoundary(surface,lh_aparc,lh_sulc,'centroid',parula(100),1,4);
camlight(80,-10);
camlight(-80,-10);

view([-90 0])

axis off
axis tight
axis equal

% Demonstrate different types of plots

surface.vertices = lh_inflated_verts;
boundary_type = {'faces','midpoint','centroid','edges','faces','midpoint','centroid','edges'};
linewidth = 2;
colorUnknownGrey = 1;

for i = 1:8

figure
    
    % The data here is just each ROIs own ID number

        if i < 5
            data = 1:100;
            cmap = lines(34);
        else
            data = lh_sulc;
            cmap = parula(100);
        end
    
    [p,~,~,~,~,orig_data_limits] = plotSurfaceROIBoundary(surface,lh_rand200,data,boundary_type{i},cmap,colorUnknownGrey,linewidth);

    camlight(80,-10);
    camlight(-80,-10);

    view([-90 0])

    axis off
    axis tight
    axis equal

    % This just zooms into the area of interest    
    ylim([-25.2699   -8.7600])
    zlim([20.2174   31.3705])

    p.EdgeColor = 'k';
    p.EdgeAlpha = .5;

end

% If you want to include a colorbar but don't want it to display the
% black/grey values, you can do:
% c = colorbar;
% set(c, 'xlim', orig_data_limits);
