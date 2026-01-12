import {
  AppComponent,
  NonAuthComponent,
  NonAuthComponentProps,
} from "@/wab/client/app-ctx";
import { PublicLink } from "@/wab/client/components/PublicLink";
import { Avatar } from "@/wab/client/components/studio/Avatar";
import { HelpButton } from "@/wab/client/components/top-bar/HelpButton";
import * as widgets from "@/wab/client/components/widgets";
import { InlineIcon } from "@/wab/client/components/widgets";
import { BrowserAlertBanner } from "@/wab/client/components/widgets/BrowserAlertBanner";
import { Icon } from "@/wab/client/components/widgets/Icon";
import MarkFullColorIcon from "@/wab/client/plasmic/plasmic_kit_design_system/PlasmicIcon__MarkFullColor";
import ChevronDownsvgIcon from "@/wab/client/plasmic/plasmic_kit_icons/icons/PlasmicIcon__ChevronDownSvg";
import { ensure } from "@/wab/shared/common";
import { APP_ROUTES } from "@/wab/shared/route/app-routes";
import { fillRoute } from "@/wab/shared/route/route";
import { Dropdown, Menu } from "antd";
import * as React from "react";
import { ReactNode } from "react";

interface NormalLayoutComponentProps {
  topBar?: ReactNode;
  children?: ReactNode;
}
class NormalLayoutComponent extends React.Component<
  NormalLayoutComponentProps,
  {}
> {
  render() {
    const { topBar } = this.props;
    return (
      <div className={"normal-layout"}>
        {topBar && (
          <div className={"normal-layout__top-bar"}>
            <div
              className={"normal-layout-content normal-layout-content--top-bar"}
            >
              <widgets.PlainLink href={"/"} className={"home-logo"} style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
                <MarkFullColorIcon className="normal-layout__mark" style={{ width: 32, height: 32 }} />
                <span style={{ fontWeight: 'bold', fontSize: '18px', color: '#333' }}>myPlasmik</span>
                <span style={{ 
                  fontSize: '10px', 
                  background: 'linear-gradient(to right, #3b82f6, #8b5cf6)', 
                  color: 'white', 
                  padding: '2px 6px', 
                  borderRadius: '10px',
                  marginLeft: '5px',
                  fontWeight: '600',
                  letterSpacing: '0.5px'
                }}>by Gemini</span>
              </widgets.PlainLink>

              {topBar}
            </div>
          </div>
        )}
        <div className={"normal-layout-content"}>{this.props.children}</div>
      </div>
    );
  }
}
interface NormalNonAuthLayoutProps extends NonAuthComponentProps {
  children?: React.ReactNode;
}
export class NormalNonAuthLayout extends NonAuthComponent<
  NormalNonAuthLayoutProps,
  {}
> {
  render() {
    return <NormalLayoutComponent>{this.props.children}</NormalLayoutComponent>;
  }
}
export class NormalLayout extends AppComponent {
  render() {
    const menu = (
      <Menu>
        <Menu.Item>
          <PublicLink href={fillRoute(APP_ROUTES.settings, {})}>
            Settings
          </PublicLink>
        </Menu.Item>
        <Menu.Item
          onClick={async () => {
            await this.logout();
          }}
        >
          Sign Out
        </Menu.Item>
      </Menu>
    );
    return (
      <>
        <BrowserAlertBanner />
        <NormalLayoutComponent
          topBar={
            <div className={"normal-layout__top-bar-right"}>
              <HelpButton />
              <Dropdown overlay={menu} trigger={["click"]}>
                <div className={"normal-layout__user"}>
                  <Avatar
                    className={"user-avatar"}
                    user={ensure(this.appCtx().selfInfo, "must have selfInfo")}
                  />
                  <InlineIcon>
                    <Icon icon={ChevronDownsvgIcon} />
                  </InlineIcon>
                </div>
              </Dropdown>
            </div>
          }
        >
          {this.props.children}
        </NormalLayoutComponent>
      </>
    );
  }
}
