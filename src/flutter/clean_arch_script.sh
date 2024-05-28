#!/bin/bash

# Source function files
source 'src/constants.sh'
source 'src/helper.sh'

# @desc : Create a new Flutter project
# @param : $1 - applicationName
# @return : void
# @example : createFlutterProject "my_app"

createFlutterProject() {
    applicationName=$1
    echo

    read -r -p "Enter the App ID (default: com.example): " appId
    read -r -p "Is your app support firebase? [y/N]: " firebaseStatus
    read -r -p "Is your app support localdb? [y/N]: " localDBStatus
    read -r -p "Is your app support localizations? [y/N]: " localizationsStatus
    read -r -p "Is your app support Multiple Env (Eg., local, dev, prod)? [y/N]: " envStatus
    read -r -p "Is your app support go_router? [y/N]: " routerStatus
    read -r -p "Is your app support state Management? [y/N]: " stateMngtStatus
    read -r -p "Is your app support Network Call (default: http)? [y/N]: " networkCallStatus

    if [ -n "$appId" ]; then
        flutter create --org "$appId" "$applicationName"
    else
        flutter create "$applicationName"
    fi

    # Go to the lib folder of the newly created project and create the src folder
    cd "$applicationName/lib" || exit
    # Create the main project structure
    mkdir -p src/{config/{api,router,themes},core/{extensions,network,resources,services,utils,widgets}}
    mkdir -p src/core/services/validator

    # Create files in the config folder
    touch src/config/api/api_collection.dart
    if confirm_command "$envStatus"; then
        mkdir -p src/config/env
        touch src/config/env/{base_env.dart,dev_env.dart,env.dart,local_env.dart,prod_env.dart}
    fi

    if confirm_command "$localizationsStatus"; then
        mkdir -p src/config/localization
        touch src/config/localization/{intl_en.arb,intl_ne.arb,l10n.dart,localization.dart}
    fi
    touch src/config/themes/app_theme.dart

    # Create files in the core folder
    touch src/core/extensions/{string_extension.dart,widget_extensions.dart}
    touch src/core/network/data_state.dart
    touch src/core/resources/{colors.dart,constants.dart,images.dart}
    if confirm_command "$firebaseStatus"; then
        echo "By default firebase support: firebase_messaging firebase_analytics firebase_crashlytics"
        mkdir -p src/core/services/firebase
        flutter pub add firebase_core firebase_messaging firebase_analytics firebase_crashlytics
        touch src/core/services/firebase/{firebase_crashlogger.dart,firebase.dart,firebase_notification.dart,firebase_services.dart,local_notification.dart}
    fi
    if confirm_command "$localDBStatus"; then
        read -r -p "Is your app support Relational DB? [y/N]: " isRelationalDB
        if confirm_command "$isRelationalDB"; then
            flutter pub add sqflite
        else
            flutter pub add hive hive_flutter
            flutter pub add -d build_runner hive_generator
        fi
        mkdir -p src/core/services/localdb
        touch src/core/services/localdb/{db.dart,db_service.dart,db_utils.dart}
    fi
    if confirm_command "$routerStatus"; then
        flutter pub add go_router
        touch src/config/router/{app_routes.dart,custom_transition.dart}
    fi
    if confirm_command "$stateMngtStatus"; then
        flutter pub add bloc flutter_bloc equatable
    fi
    if confirm_command "$networkCallStatus"; then
        flutter pub add http
    fi
    touch src/core/services/validator/validator.dart
    touch src/core/utils/common.dart
    touch src/core/widgets/{app_dialog.dart,asynctext.dart,backbutton.dart,button.dart,dropdown_search.dart,images.dart,language_switchbtn.dart,loading.dart,marquee.dart,modal_sheet.dart,readmoretext.dart,shimmer_widget.dart,skipbtn.dart,snackbar.dart,text.dart,textformfield.dart,transparent_appbar.dart}
    echo -e "\e[32m 👉 Flutter project created successfully 👏 \e[0m"
}


#@desc : Create a new feature folder structure
#@param : $1 - featureName
#@return : void
#@example : createFeatureFoldersStr "home"

createFeatureFoldersStr() {
    is_flutter_project
    local featureName="$1"

    if [ -d "$featureName" ]; then
        echo
        logError "Feature '$featureName' already exists. Please choose a different name."
        echo
        exit 1
    fi

    mkdir -p "$featureName/data/datasource/local"
    touch "$featureName/data/datasource/local/.gitkeep"
    mkdir -p "$featureName/data/datasource/remote"
    touch "$featureName/data/datasource/remote/.gitkeep"
    mkdir -p "$featureName/data/models"
    touch "$featureName/data/models/.gitkeep"
    mkdir -p "$featureName/data/repository"
    touch "$featureName/data/repository/.gitkeep"

    mkdir -p "$featureName/domain/entity"
    touch "$featureName/domain/entity/.gitkeep"
    mkdir -p "$featureName/domain/repository"
    touch "$featureName/domain/repository/.gitkeep"
    mkdir -p "$featureName/domain/usecase"
    touch "$featureName/domain/usecase/.gitkeep"

    mkdir -p "$featureName/presentation/bloc"
    touch "$featureName/presentation/bloc/.gitkeep"
    mkdir -p "$featureName/presentation/screen"
    touch "$featureName/presentation/screen/.gitkeep"
    mkdir -p "$featureName/presentation/widget"
    touch "$featureName/presentation/widget/.gitkeep"
    
    echo
    printf "%b👉 Folder structure created successfully for feature: %s 👏%b\n" "$GREEN" "$featureName" "$NC"
    echo
}