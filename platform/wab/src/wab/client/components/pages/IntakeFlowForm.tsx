import { PageFooter } from "@/wab/client/components/pages/PageFooter";
import { Icon } from "@/wab/client/components/widgets/Icon";
import MarkFullColorIcon from "@/wab/client/plasmic/plasmic_kit_design_system/PlasmicIcon__MarkFullColor";
import { Tooltip } from "antd";
import * as React from "react";
import { ReactNode } from "react";

export function IntakeFlowForm(props: { children: ReactNode }) {
  return (
    <div className={"LoginForm__Container"}>
      <div className={"LoginForm__Content"}>
        <div className={"LoginForm__Logo"}>
          <Tooltip title="myPlasmik by Gemini">
            <div style={{ display: 'flex', alignItems: 'center', gap: '15px', justifyContent: 'center' }}>
              <Icon icon={MarkFullColorIcon} style={{ width: 64, height: 64 }} />
              <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'flex-start', lineHeight: 1.2 }}>
                <span style={{
                  fontFamily: 'sans-serif',
                  fontSize: '28px',
                  fontWeight: 'bold',
                  background: 'linear-gradient(to right, #3b82f6, #8b5cf6, #ec4899)',
                  WebkitBackgroundClip: 'text',
                  WebkitTextFillColor: 'transparent'
                }}>
                  myPlasmik
                </span>
                <span style={{ fontSize: '14px', fontWeight: '500', color: '#888' }}>
                  by Gemini
                </span>
              </div>
            </div>
          </Tooltip>
        </div>
        {props.children}
        <PageFooter />
      </div>
    </div>
  );
}
