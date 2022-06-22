//
//  CameraRenderingParameters.hpp
//  WikitudeUniversalSDK
//
//  Created by Alexandru Florea on 23.03.2021.
//  Copyright © 2021 Wikitude. All rights reserved.
//

#ifndef CameraRenderingParameters_hpp
#define CameraRenderingParameters_hpp

#include "CameraPosition.hpp"

namespace wikitude::sdk {

    class WT_EXPORT_API CameraRenderingParameters {
    public:
        CameraRenderingParameters()
            : _cameraToRenderSurfaceRotation(0)
            , _cameraPosition(sdk::CameraPosition::Back) {
            /* Intentionally Left Blank */
        }

        CameraRenderingParameters(float cameraToRenderSurfaceRotation_, sdk::CameraPosition cameraPosition_)
            : _cameraToRenderSurfaceRotation(cameraToRenderSurfaceRotation_)
            , _cameraPosition(cameraPosition_) {
            /* Intentionally Left Blank */
        }

        float getCameraToRenderSurfaceRotation() const {
            return _cameraToRenderSurfaceRotation;
        }

        sdk::CameraPosition getCameraPosition() const {
            return _cameraPosition;
        }

    private:
        float _cameraToRenderSurfaceRotation;
        sdk::CameraPosition _cameraPosition;
    };
}

#endif /* CameraRenderingParameters_hpp */
