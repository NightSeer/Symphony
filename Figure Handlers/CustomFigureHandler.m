classdef CustomFigureHandler < FigureHandler
    
    properties (Constant)
        figureType = 'Custom'
    end
    
    
    properties
        updateCallback
    end
    
    
    methods
        
        function obj = CustomFigureHandler(protocolPlugin, varargin)
            obj = obj@FigureHandler(protocolPlugin);
            
            ip = inputParser;
            ip.addParamValue('Name', '', @ischar);
            ip.addParamValue('UpdateCallback', [], @(x)isa(x, 'function_handle'));
            ip.parse(varargin{:});
            
            obj.updateCallback = ip.Results.UpdateCallback;
            
            if isempty(ip.Results.Name)
                set(obj.figureHandle, 'Name', obj.protocolPlugin.displayName);
            else
                set(obj.figureHandle, 'Name', [obj.protocolPlugin.displayName ': ' ip.Results.Name]);
            end
        end
        

        function handleCurrentEpoch(obj)
            set(0, 'CurrentFigure', obj.figureHandle);
            set(obj.figureHandle, 'CurrentAxes', obj.axesHandle)
            obj.updateCallback(obj.protocolPlugin, obj.axesHandle);
        end
        
    end
    
end